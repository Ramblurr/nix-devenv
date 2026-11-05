#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s BOOK_DIRECTORY PAGE [DPI]\n' "$0" >&2
  printf 'Render a 1-based PDF page to BOOK_DIRECTORY/cache/pages/NNNN.png.\n' >&2
  printf 'Reuse cached images. Supplying DPI explicitly regenerates the image.\n' >&2
  exit 2
}

[[ $# -ge 2 && $# -le 3 ]] || usage
[[ $2 =~ ^[0-9]+$ && ${#2} -le 8 ]] || usage
page=$((10#$2))
(( page > 0 )) || usage
dpi=${3:-150}
[[ $dpi =~ ^[0-9]+$ && ${#dpi} -le 4 ]] || usage
dpi=$((10#$dpi))
(( dpi > 0 )) || usage
book=$(cd -- "$1" && pwd)
[[ -f "$book/book.pdf" ]] || { printf 'Missing PDF: %s/book.pdf\n' "$book" >&2; exit 1; }
printf -v number '%04d' "$page"
cache="$book/cache/pages"
output="$cache/$number.png"

if [[ $# -eq 2 && -s "$output" && ! "$book/book.pdf" -nt "$output" ]]; then
  printf '%s\n' "$output"
  exit 0
fi

if ! command -v pdftoppm >/dev/null 2>&1; then
  if command -v nix >/dev/null 2>&1; then
    exec nix shell nixpkgs#poppler-utils -c bash "$0" "$@"
  fi
  printf 'Install poppler-utils (pdftoppm), or provide Nix.\n' >&2
  exit 1
fi

mkdir -p -- "$cache"
work=$(mktemp -d "$cache/.render-XXXXXX")
trap 'rm -rf -- "$work"' EXIT
pdftoppm -f "$page" -l "$page" -r "$dpi" -singlefile -png \
  "$book/book.pdf" "$work/page"
[[ -s "$work/page.png" ]] || { printf 'No image produced for page %s.\n' "$page" >&2; exit 1; }
mv -f -- "$work/page.png" "$output"
printf '%s\n' "$output"
