#!/usr/bin/env bash
# common.sh — shared helpers for tools/ scripts. Source this; don't run it.

# Find repo root by walking up to the directory containing .git
find_repo_root() {
  local dir="${PWD}"
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.git" ]; then
      echo "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  echo "ERROR: not inside a git repo" >&2
  return 1
}

REPO_ROOT="$(find_repo_root)"
export REPO_ROOT

log()   { printf "\033[1;34m[*]\033[0m %s\n" "$*"; }
warn()  { printf "\033[1;33m[!]\033[0m %s\n" "$*"; }
err()   { printf "\033[1;31m[x]\033[0m %s\n" "$*" >&2; }
ok()    { printf "\033[1;32m[+]\033[0m %s\n" "$*"; }

die()   { err "$*"; exit 1; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}
