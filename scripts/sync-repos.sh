#!/bin/bash

# Repository configurations (compatible with bash 3.2+)
REPO_NAMES=("backend-main" "backend-legacy" "web-focal-os")
REPO_URLS=(
    "git@github.com:focal-systems/backend-main.git"
    "git@github.com:focal-systems/backend-legacy.git"
    "git@github.com:focal-systems/web-focal-os.git"
)

# Process each repository
for i in "${!REPO_NAMES[@]}"; do
    REPO_NAME="${REPO_NAMES[$i]}"
    REPO_URL="${REPO_URLS[$i]}"

    echo "Processing $REPO_NAME..."

    if [ -d "$REPO_NAME" ]; then
        echo "  Repository exists, updating..."
        cd "$REPO_NAME" || exit 1
        git fetch origin
        git checkout develop
        git pull origin develop
        cd ..
    else
        echo "  Repository doesn't exist, cloning..."
        git clone "$REPO_URL" "$REPO_NAME"
        cd "$REPO_NAME" || exit 1
        git checkout develop
        cd ..
    fi

    echo "  Done with $REPO_NAME"
    echo ""
done

echo "All repositories are up to date on develop branch"