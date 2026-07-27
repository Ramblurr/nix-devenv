#!/usr/bin/env python3
"""
Excel helper using LibreOffice UNO bridge.

Run directly with `python3` on PATH and `soffice` available on PATH. On
NixOS, LibreOffice's UNO Python modules and type registry live beside the
resolved `soffice` executable, so this script discovers that directory,
sets `URE_BOOTSTRAP`, and adds it to Python's import path before
importing `uno`.

Usage:
    ./scripts/excel_lo.py <command> [options]

Commands:
    info <file>
        Show sheet names and dimensions.

    read <file> --sheet <name> [--range A1:E10]
        Read cells from a sheet. Outputs JSON.

    write <file> --sheet <name> --cell A1 --value "text"
        Write a value to a cell.

    add-rows <file> --sheet <name> --after <row> --data <json_file>
        Insert rows from a JSON file after the specified row.
        JSON format: [["val1", "val2", ...], ...]

    formula <file> --sheet <name> --cell A1 --formula "=SUM(B1:B10)"
        Set a formula in a cell.

    add-sheet <file> --name <sheet_name> [--after <existing_sheet>]
        Add a new sheet.

    save-as <file> --output <output_file> [--format xlsx|pdf|csv]
        Save/export to another format.

    eval-formulas <file>
        Force recalculation of all formulas and save.

    server start
        Start the LibreOffice UNO server if it is not already running.

    server list
        List LibreOffice UNO server processes.

    server stop
        Stop only the LibreOffice UNO server processes for this helper's port.

The LibreOffice UNO server starts automatically when a command needs it and
survives this script's lifetime. Use `server stop` to shut it down.
"""

import argparse
import json
import os
from pathlib import Path
import re
import shutil
import signal
import socket
import subprocess
import sys
import time


LO_HOST = os.environ.get("EXCEL_LO_HOST", "localhost")
LO_PORT = int(os.environ.get("EXCEL_LO_PORT", "2002"))
LO_TIMEOUT = 10  # seconds to wait for LO to start


def _has_uno_bindings(path):
    """Return true when path contains LibreOffice's Python UNO modules."""
    return (path / "uno.py").is_file() and (path / "pyuno.so").exists()


def _candidate_libreoffice_program_dirs():
    """Yield likely LibreOffice program directories for NixOS and other systems."""
    env_dir = os.environ.get("LIBREOFFICE_PROGRAM_DIR")
    if env_dir:
        yield Path(env_dir).expanduser()

    for exe_name in ("soffice", "libreoffice"):
        exe = shutil.which(exe_name)
        if not exe:
            continue

        raw = Path(exe)
        try:
            resolved = raw.resolve()
        except OSError:
            resolved = raw

        for exe_path in (resolved, raw):
            # Nix wrappers usually resolve to .../lib/libreoffice/program/soffice.
            yield exe_path.parent

            # If the executable is .../bin/soffice, the UNO modules are usually
            # in the same package at .../lib/libreoffice/program.
            yield exe_path.parent.parent / "lib" / "libreoffice" / "program"

            for ancestor in exe_path.parents:
                yield ancestor / "lib" / "libreoffice" / "program"


def find_libreoffice_program_dir():
    """Find the directory that contains LibreOffice's `uno.py` and `pyuno.so`."""
    seen = set()
    checked = []
    for candidate in _candidate_libreoffice_program_dirs():
        key = str(candidate)
        if key in seen:
            continue
        seen.add(key)
        checked.append(key)
        if _has_uno_bindings(candidate):
            return candidate

    checked_msg = ", ".join(checked[:8])
    if len(checked) > 8:
        checked_msg += ", ..."
    raise RuntimeError(
        "Could not find LibreOffice UNO Python modules (`uno.py` and `pyuno.so`). "
        "Put `soffice` on PATH, run this script through its nix-shell shebang, "
        "or set LIBREOFFICE_PROGRAM_DIR to LibreOffice's program directory. "
        f"Checked: {checked_msg or 'no candidates'}"
    )


def ensure_uno_python_path():
    """Make LibreOffice's Python UNO modules and type registry available."""
    program_dir = find_libreoffice_program_dir()
    program_path = str(program_dir)

    # pyuno can import without this path, but remote UNO calls fail with
    # "type with unknown name" unless the LibreOffice registry is bootstrapped.
    os.environ.setdefault(
        "URE_BOOTSTRAP",
        f"vnd.sun.star.pathname:{program_dir / 'fundamentalrc'}",
    )

    # Keep LibreOffice's C-level socket warnings out of JSON-producing commands.
    os.environ.setdefault("SAL_LOG", "-WARN")

    if program_path not in sys.path:
        sys.path.insert(0, program_path)

    pythonpath = os.environ.get("PYTHONPATH", "")
    pythonpath_entries = [entry for entry in pythonpath.split(os.pathsep) if entry]
    if program_path not in pythonpath_entries:
        os.environ["PYTHONPATH"] = os.pathsep.join([program_path] + pythonpath_entries)

    try:
        import uno  # noqa: F401
    except ModuleNotFoundError as exc:
        raise RuntimeError(
            f"Found LibreOffice program directory at {program_dir}, but Python "
            "could not import `uno`. Check that this LibreOffice build contains "
            "compatible Python UNO bindings."
        ) from exc

    return program_dir


def server_profile_dir():
    """Return the isolated LibreOffice user profile directory for this server."""
    env_dir = os.environ.get("EXCEL_LO_PROFILE_DIR")
    if env_dir:
        return Path(env_dir).expanduser()

    runtime_dir = os.environ.get("XDG_RUNTIME_DIR")
    if runtime_dir:
        base_dir = Path(runtime_dir)
    else:
        base_dir = Path("/tmp") / f"excel-lo-{os.getuid()}"
    return base_dir / f"excel-lo-profile-{LO_PORT}"


def file_url_for_path(path):
    """Convert a filesystem path to a file:// URL for LibreOffice arguments."""
    from urllib.parse import quote
    return "file://" + quote(str(path.resolve(strict=False)), safe="/:@")


def server_profile_url():
    """Return the LibreOffice file URL for the isolated server profile."""
    profile_dir = server_profile_dir()
    profile_dir.mkdir(parents=True, exist_ok=True)
    return file_url_for_path(profile_dir)


def server_accept_value():
    """Return the UNO accept string used by this helper."""
    return f"socket,host={LO_HOST},port={LO_PORT};urp;"


def server_uno_url():
    """Return the UNO URL used to connect to the helper server."""
    return f"uno:{server_accept_value()}StarOffice.ComponentContext"


def _process_argv(pid):
    """Read argv for a process from /proc."""
    try:
        data = (Path("/proc") / str(pid) / "cmdline").read_bytes()
    except OSError:
        return []
    return [arg.decode("utf-8", errors="replace") for arg in data.split(b"\0") if arg]


def _looks_like_soffice(argv):
    """Return true when argv belongs to the actual LibreOffice server process."""
    if not argv:
        return False
    return Path(argv[0]).name in {"soffice", "soffice.bin", "libreoffice", "libreoffice.bin"}


def _extract_accept_values(argv):
    """Extract --accept values from a process argv list."""
    values = []
    for i, arg in enumerate(argv):
        if arg.startswith("--accept="):
            values.append(arg.split("=", 1)[1])
        elif arg == "--accept" and i + 1 < len(argv):
            values.append(argv[i + 1])
    return values


def _parse_accept_value(value):
    """Parse a LibreOffice UNO --accept value."""
    if not value.startswith("socket") or ";urp" not in value:
        return None
    port_match = re.search(r"(?:^|[,;])port=(\d+)(?:[,;]|$)", value)
    if not port_match:
        return None
    host_match = re.search(r"(?:^|[,;])host=([^,;]+)(?:[,;]|$)", value)
    return {
        "host": host_match.group(1) if host_match else None,
        "port": int(port_match.group(1)),
        "accept": value,
    }


def _extract_user_installation(argv):
    """Extract -env:UserInstallation from a process argv list."""
    prefix = "-env:UserInstallation="
    for arg in argv:
        if arg.startswith(prefix):
            return arg[len(prefix):]
    return None


def _path_from_file_url(value):
    """Convert a file:// URL to a path when possible."""
    if not value:
        return None
    from urllib.parse import unquote, urlparse
    parsed = urlparse(value)
    if parsed.scheme != "file":
        return None
    return Path(unquote(parsed.path))


def list_uno_servers(port=None):
    """List LibreOffice UNO server processes, optionally restricted by port."""
    servers = []
    proc_root = Path("/proc")
    if not proc_root.exists():
        return servers

    managed_profile = server_profile_dir().resolve(strict=False)
    for proc_entry in proc_root.iterdir():
        if not proc_entry.name.isdigit():
            continue
        pid = int(proc_entry.name)
        argv = _process_argv(pid)
        if not argv or not _looks_like_soffice(argv):
            continue

        profile_url = _extract_user_installation(argv)
        profile_path = _path_from_file_url(profile_url)
        managed = (
            profile_path is not None
            and profile_path.resolve(strict=False) == managed_profile
        )

        for accept_value in _extract_accept_values(argv):
            accept = _parse_accept_value(accept_value)
            if not accept:
                continue
            if port is not None and accept["port"] != port:
                continue
            servers.append({
                "pid": pid,
                "host": accept["host"],
                "port": accept["port"],
                "managed": managed,
                "profile": profile_url,
                "command": " ".join(argv),
            })

    return sorted(servers, key=lambda server: server["pid"])


def is_server_listening():
    """Return true when something accepts TCP connections on the UNO port."""
    try:
        with socket.create_connection((LO_HOST, LO_PORT), timeout=0.25):
            return True
    except OSError:
        return False


def connect_to_server(quiet=False):
    """Connect to the LibreOffice UNO server and return its component context."""
    ensure_uno_python_path()
    import uno

    def resolve():
        local_context = uno.getComponentContext()
        resolver = local_context.ServiceManager.createInstanceWithContext(
            "com.sun.star.bridge.UnoUrlResolver", local_context)
        return resolver.resolve(server_uno_url())

    if not quiet:
        return resolve()

    saved_stderr = os.dup(2)
    try:
        with open(os.devnull, "w", encoding="utf-8") as devnull:
            os.dup2(devnull.fileno(), 2)
            return resolve()
    finally:
        os.dup2(saved_stderr, 2)
        os.close(saved_stderr)


def start_libreoffice():
    """Ensure the LibreOffice UNO server is running. Return true if started."""
    ensure_uno_python_path()

    if is_server_listening():
        try:
            connect_to_server(quiet=True)
            return False
        except Exception:
            pass

    # Start fresh. Keep URE_BOOTSTRAP in this Python process for pyuno's type
    # registry, but do not pass it to soffice: it prevents the server from
    # opening the requested --accept socket on NixOS LibreOffice wrappers.
    soffice_env = os.environ.copy()
    soffice_env.pop("URE_BOOTSTRAP", None)
    subprocess.Popen(
        [
            "soffice",
            "--headless",
            "--norestore",
            "--nologo",
            "--nodefault",
            "--nofirststartwizard",
            f"-env:UserInstallation={server_profile_url()}",
            f"--accept={server_accept_value()}",
        ],
        env=soffice_env,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
    )

    # Wait for it to be ready. Probe the TCP port first; quiet failed UNO
    # handshakes because LibreOffice logs C-level socket warnings to stderr.
    deadline = time.monotonic() + LO_TIMEOUT
    while time.monotonic() < deadline:
        time.sleep(0.25)
        if not is_server_listening():
            continue
        try:
            connect_to_server(quiet=True)
            return True
        except Exception:
            continue
    raise RuntimeError("Failed to start LibreOffice within timeout")


def stop_libreoffice():
    """Stop only LibreOffice UNO processes for this helper's port."""
    servers = list_uno_servers(port=LO_PORT)
    pids = sorted({server["pid"] for server in servers})
    errors = []

    for pid in pids:
        try:
            os.kill(pid, signal.SIGTERM)
        except ProcessLookupError:
            pass
        except PermissionError as exc:
            errors.append({"pid": pid, "error": str(exc)})

    deadline = time.monotonic() + 5
    remaining = set(pids)
    while remaining and time.monotonic() < deadline:
        time.sleep(0.1)
        remaining = {pid for pid in remaining if (Path("/proc") / str(pid)).exists()}

    for pid in list(remaining):
        try:
            os.kill(pid, signal.SIGKILL)
        except ProcessLookupError:
            remaining.discard(pid)
        except PermissionError as exc:
            errors.append({"pid": pid, "error": str(exc)})

    return {
        "status": "ok",
        "host": LO_HOST,
        "port": LO_PORT,
        "stopped": len(pids),
        "pids": pids,
        "errors": errors,
    }


def get_desktop():
    """Get the LibreOffice Desktop object via UNO."""
    ctx = connect_to_server()
    smgr = ctx.ServiceManager
    return smgr.createInstanceWithContext("com.sun.star.frame.Desktop", ctx)


def open_document(desktop, filepath):
    """Open a document and return it."""
    from urllib.parse import quote
    abspath = os.path.abspath(filepath)
    url = "file://" + quote(abspath, safe="/:@")
    doc = desktop.loadComponentFromURL(url, "_blank", 0, ())
    if not doc:
        raise RuntimeError(f"Failed to open: {filepath}")
    return doc


def col_letter_to_index(letter):
    """Convert column letter(s) to 0-based index. A=0, B=1, Z=25, AA=26."""
    result = 0
    for char in letter.upper():
        result = result * 26 + (ord(char) - ord('A') + 1)
    return result - 1


def parse_cell_ref(ref):
    """Parse a cell reference like 'A1' into (col_index, row_index)."""
    match = re.match(r'^([A-Za-z]+)(\d+)$', ref)
    if not match:
        raise ValueError(f"Invalid cell reference: {ref}")
    col = col_letter_to_index(match.group(1))
    row = int(match.group(2)) - 1  # 0-based
    return col, row


def parse_range(range_str):
    """Parse a range like 'A1:E10' into ((col1, row1), (col2, row2))."""
    parts = range_str.split(':')
    if len(parts) != 2:
        raise ValueError(f"Invalid range: {range_str}")
    return parse_cell_ref(parts[0]), parse_cell_ref(parts[1])


def get_cell_value(cell):
    """Get the display value of a cell."""
    from com.sun.star.table.CellContentType import EMPTY, VALUE, TEXT, FORMULA
    ctype = cell.getType()
    if ctype == EMPTY:
        return ""
    elif ctype == VALUE:
        val = cell.getValue()
        # Return int if it's a whole number
        if val == int(val):
            return int(val)
        return val
    elif ctype == TEXT:
        return cell.getString()
    elif ctype == FORMULA:
        # Return the computed value
        val = cell.getValue()
        s = cell.getString()
        if s and not s.replace('.', '').replace(',', '').replace('-', '').isdigit():
            return s
        if val == int(val):
            return int(val)
        return val
    return cell.getString()


def cmd_info(args):
    """Show info about an Excel file."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        sheets = doc.getSheets()
        result = {"file": args.file, "sheets": []}
        for i in range(sheets.getCount()):
            sheet = sheets.getByIndex(i)
            name = sheet.getName()

            # Find used range
            cursor = sheet.createCursor()
            cursor.gotoStartOfUsedArea(False)
            cursor.gotoEndOfUsedArea(True)
            rows = cursor.getRangeAddress().EndRow + 1
            cols = cursor.getRangeAddress().EndColumn + 1

            result["sheets"].append({
                "name": name,
                "rows": rows,
                "columns": cols
            })
        print(json.dumps(result, ensure_ascii=False, indent=2))
    finally:
        doc.close(True)


def cmd_read(args):
    """Read cells from a sheet."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        sheets = doc.getSheets()
        sheet = sheets.getByName(args.sheet)

        if args.range:
            (c1, r1), (c2, r2) = parse_range(args.range)
        else:
            cursor = sheet.createCursor()
            cursor.gotoStartOfUsedArea(False)
            cursor.gotoEndOfUsedArea(True)
            addr = cursor.getRangeAddress()
            c1, r1 = addr.StartColumn, addr.StartRow
            c2, r2 = addr.EndColumn, addr.EndRow

        data = []
        for row in range(r1, r2 + 1):
            row_data = []
            for col in range(c1, c2 + 1):
                cell = sheet.getCellByPosition(col, row)
                row_data.append(get_cell_value(cell))
            data.append(row_data)

        print(json.dumps(data, ensure_ascii=False, indent=2))
    finally:
        doc.close(True)


def cmd_write(args):
    """Write a value to a cell."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        sheets = doc.getSheets()
        sheet = sheets.getByName(args.sheet)
        col, row = parse_cell_ref(args.cell)
        cell = sheet.getCellByPosition(col, row)

        # Try to set as number, fall back to string
        try:
            val = float(args.value.replace(',', '.'))
            cell.setValue(val)
        except ValueError:
            cell.setString(args.value)

        doc.store()
        print(json.dumps({"status": "ok", "cell": args.cell, "value": args.value}))
    finally:
        doc.close(True)


def cmd_add_rows(args):
    """Insert rows from a JSON file."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        sheets = doc.getSheets()
        sheet = sheets.getByName(args.sheet)

        with open(args.data, 'r', encoding='utf-8') as f:
            rows_data = json.load(f)

        insert_row = args.after  # 1-based row number
        num_rows = len(rows_data)

        # Insert empty rows
        sheet.getRows().insertByIndex(insert_row, num_rows)

        # Fill in data
        for i, row_data in enumerate(rows_data):
            for j, val in enumerate(row_data):
                cell = sheet.getCellByPosition(j, insert_row + i)
                if val is None or val == "":
                    continue
                try:
                    num_val = float(str(val).replace(',', '.'))
                    cell.setValue(num_val)
                except (ValueError, TypeError):
                    cell.setString(str(val))

        doc.store()
        print(json.dumps({
            "status": "ok",
            "rows_added": num_rows,
            "after_row": insert_row
        }))
    finally:
        doc.close(True)


def cmd_formula(args):
    """Set a formula in a cell."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        sheets = doc.getSheets()
        sheet = sheets.getByName(args.sheet)
        col, row = parse_cell_ref(args.cell)
        cell = sheet.getCellByPosition(col, row)
        cell.setFormula(args.formula)
        doc.store()

        # Read back computed value
        computed = get_cell_value(cell)
        print(json.dumps({
            "status": "ok",
            "cell": args.cell,
            "formula": args.formula,
            "computed_value": computed
        }, ensure_ascii=False))
    finally:
        doc.close(True)


def cmd_add_sheet(args):
    """Add a new sheet."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        sheets = doc.getSheets()
        if args.after:
            # Find position of the reference sheet
            for i in range(sheets.getCount()):
                if sheets.getByIndex(i).getName() == args.after:
                    sheets.insertNewByName(args.name, i + 1)
                    break
            else:
                sheets.insertNewByName(args.name, sheets.getCount())
        else:
            sheets.insertNewByName(args.name, sheets.getCount())
        doc.store()
        print(json.dumps({"status": "ok", "sheet": args.name}))
    finally:
        doc.close(True)


def cmd_save_as(args):
    """Save/export to another format."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        output_path = os.path.abspath(args.output)
        from urllib.parse import quote
        url = "file://" + quote(output_path, safe="/:@")

        fmt = args.format or os.path.splitext(args.output)[1].lstrip('.')

        filter_map = {
            'xlsx': 'Calc MS Excel 2007 XML',
            'xls': 'MS Excel 97',
            'csv': 'Text - txt - csv (StarCalc)',
            'pdf': 'calc_pdf_Export',
            'ods': 'calc8',
        }

        filter_name = filter_map.get(fmt)
        if not filter_name:
            raise ValueError(f"Unsupported format: {fmt}")

        from com.sun.star.beans import PropertyValue
        props = []
        p = PropertyValue()
        p.Name = "FilterName"
        p.Value = filter_name
        props.append(p)

        if fmt == 'pdf':
            doc.storeToURL(url, tuple(props))
        else:
            doc.storeToURL(url, tuple(props))

        print(json.dumps({
            "status": "ok",
            "output": output_path,
            "format": fmt
        }))
    finally:
        doc.close(True)


def cmd_eval_formulas(args):
    """Force recalculation of all formulas and save."""
    start_libreoffice()
    desktop = get_desktop()
    doc = open_document(desktop, args.file)
    try:
        # Force recalculation
        doc.calculateAll()
        doc.store()
        print(json.dumps({"status": "ok", "message": "Formulas recalculated and saved"}))
    finally:
        doc.close(True)


def cmd_server_start(args):
    """Start the LibreOffice UNO server."""
    started = start_libreoffice()
    print(json.dumps({
        "status": "ok",
        "action": "started" if started else "already-running",
        "host": LO_HOST,
        "port": LO_PORT,
        "profile": str(server_profile_dir()),
        "servers": list_uno_servers(port=LO_PORT),
    }, ensure_ascii=False, indent=2))


def cmd_server_list(args):
    """List LibreOffice UNO server processes."""
    print(json.dumps({
        "status": "ok",
        "host": LO_HOST,
        "port": LO_PORT,
        "servers": list_uno_servers(),
    }, ensure_ascii=False, indent=2))


def cmd_server_stop(args):
    """Stop the LibreOffice UNO server."""
    result = stop_libreoffice()
    result["servers"] = list_uno_servers(port=LO_PORT)
    print(json.dumps(result, ensure_ascii=False, indent=2))


def main():
    parser = argparse.ArgumentParser(description="Excel helper via LibreOffice UNO")
    subparsers = parser.add_subparsers(dest="command", required=True)

    # info
    p = subparsers.add_parser("info")
    p.add_argument("file")

    # read
    p = subparsers.add_parser("read")
    p.add_argument("file")
    p.add_argument("--sheet", required=True)
    p.add_argument("--range", default=None)

    # write
    p = subparsers.add_parser("write")
    p.add_argument("file")
    p.add_argument("--sheet", required=True)
    p.add_argument("--cell", required=True)
    p.add_argument("--value", required=True)

    # add-rows
    p = subparsers.add_parser("add-rows")
    p.add_argument("file")
    p.add_argument("--sheet", required=True)
    p.add_argument("--after", type=int, required=True, help="1-based row number")
    p.add_argument("--data", required=True, help="Path to JSON file with row data")

    # formula
    p = subparsers.add_parser("formula")
    p.add_argument("file")
    p.add_argument("--sheet", required=True)
    p.add_argument("--cell", required=True)
    p.add_argument("--formula", required=True)

    # add-sheet
    p = subparsers.add_parser("add-sheet")
    p.add_argument("file")
    p.add_argument("--name", required=True)
    p.add_argument("--after", default=None)

    # save-as
    p = subparsers.add_parser("save-as")
    p.add_argument("file")
    p.add_argument("--output", required=True)
    p.add_argument("--format", default=None)

    # eval-formulas
    p = subparsers.add_parser("eval-formulas")
    p.add_argument("file")

    # server
    p = subparsers.add_parser("server")
    server_subparsers = p.add_subparsers(dest="server_command", required=True)
    server_subparsers.add_parser("start")
    server_subparsers.add_parser("list")
    server_subparsers.add_parser("stop")

    args = parser.parse_args()

    try:
        if args.command == "server":
            cmd_func = {
                "start": cmd_server_start,
                "list": cmd_server_list,
                "stop": cmd_server_stop,
            }[args.server_command]
        else:
            cmd_func = {
                "info": cmd_info,
                "read": cmd_read,
                "write": cmd_write,
                "add-rows": cmd_add_rows,
                "formula": cmd_formula,
                "add-sheet": cmd_add_sheet,
                "save-as": cmd_save_as,
                "eval-formulas": cmd_eval_formulas,
            }[args.command]
        cmd_func(args)
    except Exception as e:
        print(json.dumps({"error": str(e)}), file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
