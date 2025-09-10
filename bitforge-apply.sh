#!/bin/bash
set -euo pipefail

PATCH_DIR="bitforge-patches"
ASSETS_DIR="$PATCH_DIR/picture"

# 1. Apply all patch files
if [ -d "$PATCH_DIR" ]; then
    find "$PATCH_DIR" -name "*.patch" | sort | while IFS= read -r patch; do
        echo "Applying patch: $patch"
        git apply --index "$patch"
    done
    echo "All patches applied."
else
    echo "Patch directory '$PATCH_DIR' not found!"
fi

# 2. Copy all picture
if [ -d "$ASSETS_DIR" ]; then
    echo "Copying picture..."
    # preserve folder structure
    cp -r "$ASSETS_DIR/"* .
    echo "All picture copied."
else
    echo "No picture to copy."
fi

echo "Done!"
