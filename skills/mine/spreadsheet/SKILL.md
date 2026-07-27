---
name: spreadsheet
description: Create, inspect, edit, recalculate, and export spreadsheet files using LibreOffice UNO and Python libraries. Use when working with .xlsx, .xls, .ods, .csv files, spreadsheet formulas, charts, data analysis, or exporting spreadsheets to PDF.
---

# Spreadsheet

Create, read, edit, recalculate, and export Excel/ODS/CSV spreadsheets. Prefer deterministic scripts for workbook operations and Python libraries for data analysis or generating new files.

## LibreOffice UNO (primary)

Use LibreOffice UNO for full spreadsheet compatibility: formula evaluation, existing workbook edits, charts, and format conversion. The helper is executable with a `python3` shebang and expects `soffice` on PATH. It discovers LibreOffice's UNO Python modules from `soffice`, sets `URE_BOOTSTRAP` for Python's type registry, and manages a persistent headless UNO server.

**Helper script:** `scripts/excel_lo.py`

Paths in this skill are relative to this `SKILL.md`. Run the helper directly:

```bash
# File info (sheets, dimensions)
./scripts/excel_lo.py info /path/to/file.xlsx

# Read a sheet (outputs JSON)
./scripts/excel_lo.py read /path/to/file.xlsx --sheet "Sheet1"
./scripts/excel_lo.py read /path/to/file.xlsx --sheet "Sheet1" --range A1:E10

# Write a cell value
./scripts/excel_lo.py write /path/to/file.xlsx --sheet "Sheet1" --cell A1 --value "text"

# Insert rows from JSON
./scripts/excel_lo.py add-rows /path/to/file.xlsx --sheet "Sheet1" --after 5 --data /tmp/rows.json

# Set a formula
./scripts/excel_lo.py formula /path/to/file.xlsx --sheet "Sheet1" --cell C1 --formula "=SUM(A1:B1)"

# Add a new sheet
./scripts/excel_lo.py add-sheet /path/to/file.xlsx --name "NewSheet"

# Export to another format (xlsx, xls, csv, pdf, ods)
./scripts/excel_lo.py save-as /path/to/file.xlsx --output /tmp/output.pdf --format pdf

# Recalculate all formulas
./scripts/excel_lo.py eval-formulas /path/to/file.xlsx

# Start server explicitly (optional; commands auto-start it)
./scripts/excel_lo.py server start

# List server processes
./scripts/excel_lo.py server list

# Stop only this helper's UNO server processes
./scripts/excel_lo.py server stop
```

## Python libraries

Use these when available in the current Python environment:

- `openpyxl`: create/edit workbooks and precise workbook formatting.
- `xlsxwriter`: create new workbooks with charts.
- `pandas`: analyze, transform, import, and export Excel/CSV data.
- `seaborn` / `matplotlib`: export chart images.

```python
import pandas as pd

df = pd.read_excel("/path/to/file.xlsx", sheet_name="Sheet1")
df.groupby("category").sum().to_excel("/tmp/summary.xlsx")
```

## Choose the tool

| Task | Tool |
|------|------|
| Read/edit existing Excel with formulas | LibreOffice UNO |
| Export to PDF or other spreadsheet formats | LibreOffice UNO |
| Recalculate formulas | LibreOffice UNO |
| Create a spreadsheet from scratch | openpyxl or xlsxwriter |
| Create spreadsheets with charts | xlsxwriter or LibreOffice |
| Analyze/transform tabular data | pandas |
| Generate chart images | seaborn/matplotlib |

## Notes

- `server start` is optional; workbook commands auto-start the UNO server when needed.
- The UNO server survives script exit. Use `./scripts/excel_lo.py server stop` when done.
- `server stop` targets only processes for this helper's UNO port, not arbitrary `soffice.bin` processes.
- Supported formats: xlsx, xls, ods, csv, pdf.
