#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBLISH_DIR="${PUBLISH_DIR:-/tmp/small-japan-moments-gh-pages}"

cd "$ROOT"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "ERROR: working tree has uncommitted changes. Commit main changes first." >&2
  git status --short >&2
  exit 1
fi

git fetch origin --prune

if ! git show-ref --verify --quiet refs/heads/gh-pages; then
  if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    git branch gh-pages origin/gh-pages
  else
    git switch --orphan gh-pages
    git rm -rf . >/dev/null 2>&1 || true
    printf '%s\n' '<!doctype html><title>Small Japan Moments</title>' > index.html
    git add index.html
    git commit -m "Initialize gh-pages branch"
    git switch main
  fi
fi

if [ ! -d "$PUBLISH_DIR/.git" ]; then
  rm -rf "$PUBLISH_DIR"
  git worktree prune
  git worktree add -f "$PUBLISH_DIR" gh-pages
fi

if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
  git -C "$PUBLISH_DIR" fetch origin --prune
  git -C "$PUBLISH_DIR" checkout gh-pages
  git -C "$PUBLISH_DIR" reset --hard origin/gh-pages
fi

rsync -a --delete \
  --exclude '.git' \
  --exclude '.github' \
  --exclude 'scripts' \
  --exclude 'README.md' \
  "$ROOT"/ "$PUBLISH_DIR"/

git -C "$PUBLISH_DIR" diff --check

git -C "$PUBLISH_DIR" add -A
if git -C "$PUBLISH_DIR" diff --cached --quiet; then
  echo "No gh-pages changes to publish."
  exit 0
fi

git -C "$PUBLISH_DIR" commit -m "Publish latest site updates"
git -C "$PUBLISH_DIR" push origin gh-pages
