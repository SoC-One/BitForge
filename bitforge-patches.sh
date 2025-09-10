#!/bin/bash
set -euo pipefail

OUT_DIR="bitforge-patches"
ASSETS_DIR="$OUT_DIR/picture"

mkdir -p "$ASSETS_DIR"

git diff --name-only | while IFS= read -r file; do
    case "$file" in
        *.png|*.jpg|*.jpeg|*.gif|*.ico|*.svg|*.webp)
            echo "Copy binary asset: $file"
            mkdir -p "$ASSETS_DIR/$(dirname "$file")"
            cp "$file" "$ASSETS_DIR/$file"
            ;;
        *)
            patch_file="$OUT_DIR/$(echo "$file" | cut -d/ -f1).patch"
            mkdir -p "$(dirname "$patch_file")"
            echo "Generating patch for $file -> $patch_file"
            git diff "$file" >> "$patch_file"
            ;;
    esac
done
