#!/usr/bin/env bash
set -eu

GIT_TOP=$(git rev-parse --show-toplevel)

update_readme() {
  local README="$GIT_TOP/README.md"
  printf "#blog\n\n" > "$README"
  for a in $(ls "$GIT_TOP/articles" | sort -r); do
    echo "- [$a]($a)" >> "$README"
  done
  printf "\n" >> "$README"
}

update_readme

