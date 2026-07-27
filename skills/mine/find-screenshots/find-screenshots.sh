#!/usr/bin/env bash
set -euo pipefail

limit="${1:-5}"

if ! [[ "$limit" =~ ^[0-9]+$ ]] || [[ "$limit" -lt 1 ]]; then
    echo "Usage: $0 [positive-result-limit]" >&2
    exit 2
fi

screenshot_dirs=()
candidates=(
    "${XDG_SCREENSHOTS_DIR:-}"
    "$HOME/Pictures/Screenshots"
    "$HOME/Screenshots"
    "${XDG_DOWNLOAD_DIR:-}"
    "$HOME/Downloads"
)

for dir in "${candidates[@]}"; do
    if [[ -n "$dir" && -d "$dir" ]]; then
        duplicate=false
        for existing_dir in "${screenshot_dirs[@]}"; do
            if [[ "$existing_dir" == "$dir" ]]; then
                duplicate=true
                break
            fi
        done

        if [[ "$duplicate" == false ]]; then
            screenshot_dirs+=("$dir")
        fi
    fi
done

if [[ "${#screenshot_dirs[@]}" -eq 0 ]]; then
    echo "No screenshot directories found" >&2
    exit 1
fi

echo "Current time: $(date '+%Y-%m-%d %H:%M.%S')" >&2
echo "Screenshot directories:" >&2
printf '  %s\n' "${screenshot_dirs[@]}" >&2
echo
echo "Latest $limit screenshots:"

find "${screenshot_dirs[@]}" -maxdepth 2 -type f \
    \( -iname '*screenshot*.png' \
    -o -iname '*screenshot*.jpg' \
    -o -iname '*screenshot*.jpeg' \
    -o -iname '*screenshot*.gif' \
    -o -iname '*screenshot*.webp' \
    -o -iname '*screenshot*.heic' \
    -o -iname '*screenshot*.bmp' \
    -o -iname '*screenshot*.tif' \
    -o -iname '*screenshot*.tiff' \) \
    -printf '%T@\t%p\n' |
    sort -rn |
    awk -v limit="$limit" 'NR <= limit { sub(/^[^\t]*\t/, ""); print }'
