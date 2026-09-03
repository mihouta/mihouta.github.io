#!/usr/bin/env bash

set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
posts_dir="$project_root/src/content/posts"

if (( $# > 1 )); then
    printf 'Usage: %s [markdown-file-name]\n' "${0##*/}" >&2
    exit 2
fi

if (( $# == 1 )); then
    post_name=$1
else
    read -r -p 'Markdown file name (the .md extension is optional): ' post_name
fi

# Trim whitespace and an optional .md suffix.
post_name=${post_name#"${post_name%%[![:space:]]*}"}
post_name=${post_name%"${post_name##*[![:space:]]}"}
shopt -s nocasematch
[[ $post_name == *.md ]] && post_name=${post_name::-3}
shopt -u nocasematch
post_name=${post_name#"${post_name%%[![:space:]]*}"}
post_name=${post_name%"${post_name##*[![:space:]]}"}

if [[ -z $post_name ]]; then
    printf 'ERROR: The file name cannot be empty.\n' >&2
    exit 1
fi

if [[ $post_name == '.' || $post_name == '..' || $post_name == */* || $post_name == *$'\n'* || $post_name == *$'\r'* ]]; then
    printf 'ERROR: The file name contains unsupported characters.\n' >&2
    exit 1
fi

target="$posts_dir/$post_name.md"
if [[ -e $target ]]; then
    printf 'ERROR: The post already exists: %s\n' "$target" >&2
    exit 1
fi

mkdir -p -- "$posts_dir"
timestamp=$(TZ=Asia/Shanghai date '+%Y-%m-%dT%H:%M:%S%:z')
yaml_title=${post_name//\'/\'\'}

printf '%s\n' \
    '---' \
    "title: '$yaml_title'" \
    "pubDatetime: $timestamp" \
    "modDatetime: $timestamp" \
    'tags: []' \
    'draft: true' \
    "description: ''" \
    '---' \
    '' > "$target"

printf 'Created: %s\n' "$target"
printf 'You can start writing now.\n'
