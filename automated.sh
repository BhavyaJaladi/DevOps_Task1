#!/bin/bash

# Directory to monitor (change this to your repo's directory)
WATCH_DIR="./"

# Commit message
COMMIT_MESSAGE="Auto-commit: changes detected"

# Move to the repo directory
cd "$WATCH_DIR" || exit

echo "Monitoring $WATCH_DIR for changes..."

# Store initial commit hash
LAST_HASH=$(git rev-parse HEAD 2>/dev/null || echo "NO_COMMIT")

# Check for any changes
git add -A > /dev/null 2>&1
if ! git diff --cached --quiet; then
    echo "Changes detected. Running git commit..."
    git commit -m "$COMMIT_MESSAGE"
    
    # Update LAST_HASH with the latest commit hash
    LAST_HASH=$(git rev-parse HEAD)
    echo "Committed changes. Waiting for new modifications..."
fi