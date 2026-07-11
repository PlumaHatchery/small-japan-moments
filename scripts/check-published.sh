#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBLISH_DIR="${PUBLISH_DIR:-/tmp/small-japan-moments-gh-pages}"

cd "$ROOT"

git fetch origin --prune >/dev/null

if ! git show-ref --verify --quiet refs/heads/gh-pages; then
  if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    git branch gh-pages origin/gh-pages >/dev/null
  else
    echo "ERROR: gh-pages branch does not exist." >&2
    exit 1
  fi
fi

if ! git -C "$PUBLISH_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  rm -rf "$PUBLISH_DIR"
  git worktree prune >/dev/null
  git worktree add -f "$PUBLISH_DIR" gh-pages >/dev/null
fi

git -C "$PUBLISH_DIR" fetch origin --prune >/dev/null
git -C "$PUBLISH_DIR" checkout gh-pages >/dev/null
git -C "$PUBLISH_DIR" reset --hard origin/gh-pages >/dev/null

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

rsync -a --delete \
  --exclude '.git' \
  --exclude '.github' \
  --exclude 'scripts' \
  --exclude 'README.md' \
  "$ROOT"/ "$TMP_DIR/current"/

rsync -a --delete \
  --exclude '.git' \
  "$PUBLISH_DIR"/ "$TMP_DIR/published"/

if diff -qr "$TMP_DIR/current" "$TMP_DIR/published"; then
  echo "OK: gh-pages matches main publishable files."
else
  echo "ERROR: gh-pages is behind main publishable files. Run ./scripts/publish-gh-pages.sh" >&2
  exit 1
fi
