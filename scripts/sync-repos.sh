#!/bin/bash

# Repository configurations
declare -A REPOS=(
    ["backend-main"]="git@github.com:focal-systems/backend-main.git"
    ["backend-legacy"]="git@github.com:focal-systems/backend-legacy.git"
    ["web-focal-os"]="git@github.com:focal-systems/web-focal-os.git"
)

# Process each repository
for REPO_NAME in "${!REPOS[@]}"; do
    REPO_URL="${REPOS[$REPO_NAME]}"

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