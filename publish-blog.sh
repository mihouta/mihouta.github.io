#!/usr/bin/env bash

set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd -- "$project_root"

if ! command -v git >/dev/null 2>&1; then
    printf 'ERROR: Git was not found. Please install Git or add it to PATH.\n' >&2
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf 'ERROR: This script is not inside a Git repository.\n' >&2
    exit 1
fi

current_branch=$(git branch --show-current)
if [[ $current_branch != main ]]; then
    printf 'ERROR: Current branch is "%s", but GitHub Pages deploys from "main".\n' "$current_branch" >&2
    exit 1
fi

printf 'Staging saved changes...\n'
git add --all

if git diff --cached --quiet; then
    printf 'No saved changes were found. Nothing was published.\n'
    exit 0
fi

publish_time=$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S')
printf 'Creating commit...\n'
git commit -m "Update blog $publish_time"

printf 'Pushing to GitHub...\n'
git push origin main

printf '%s\n' \
    'Push completed successfully.' \
    'GitHub Actions is now building: https://github.com/mihouta/mihouta.github.io/actions' \
    'Blog: https://mihouta.github.io/'
