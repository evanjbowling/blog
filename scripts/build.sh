#!/usr/bin/env bash
set -eu

GIT_TOP=$(git rev-parse --show-toplevel)

update_index() {
  local INDEX="$GIT_TOP/index.md"
  printf "# Articles\n\n" > "$INDEX"
  for a in $(git -C "$GIT_TOP" ls-files articles/ | sed 's|articles/||' | cut -d'/' -f1 | sort -ru); do
    echo "- [${a}](articles/${a})" >> "${INDEX}"
  done
  printf "\n" >> "${INDEX}"
}

update_index

