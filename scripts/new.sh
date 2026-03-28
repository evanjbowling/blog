#!/usr/bin/env bash
set -eu

if [ $# -ne 1 ]; then
  echo "USAGE: $0 article-name"
  exit 1
fi

DIR="articles/$(date "+%Y-%m-%d")-$1"
mkdir "$DIR"
echo "# $1" > "${DIR}/README.md"

