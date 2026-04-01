#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: search-src.sh [--max-results N] <pattern>

Search file contents under ~/src with ripgrep.
Print at most N matching lines, then report total matches and whether output was truncated.
EOF
}

max_results=20
pattern=

while [[ $# -gt 0 ]]; do
  case "$1" in
    --max-results)
      max_results="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      pattern="$1"
      shift
      ;;
  esac
done

if [[ -z "${pattern}" ]]; then
  usage >&2
  exit 2
fi

src_root="${HOME}/src"
if [[ ! -d "${src_root}" ]]; then
  src_root="$HOME/../src"
fi
if [[ ! -d "${src_root}" ]]; then
  echo "~/src does not exist: ${HOME}/src" >&2
  exit 1
fi

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

rg --smart-case --line-number --color=never --no-heading --hidden \
  -g '!.git' -g '!node_modules' -g '!dist' -g '!build' -g '!target' \
  -- "$pattern" "$src_root" > "$tmp" || true

total=$(wc -l < "$tmp" | tr -d ' ')
shown=$(( total < max_results ? total : max_results ))

echo "search-src: pattern=${pattern@Q} root=${src_root} total_matches=${total} showing=${shown} max_results=${max_results}"

if (( total == 0 )); then
  exit 0
fi

sed -n "1,${max_results}p" "$tmp"

if (( total > max_results )); then
  echo "search-src: truncated output; ${total} matches found, ${shown} shown, $(( total - shown )) omitted" >&2
fi
