#!/usr/bin/env bash
set -e

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

for arg in "$@"; do
    if [[ "$arg" == *=* ]]; then
        target=${arg%%=*}
        tag=${arg#*=}

        if ! docker image inspect "$tag" &>/dev/null; then
            docker build -t "$tag" --target "$target" "$script_dir"
        fi
    else
        echo "Error: argument '$arg' does not match the 'target=tag' format" >&2
        exit 1
    fi
done
