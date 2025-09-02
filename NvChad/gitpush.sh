#!/bin/bash

# 1. Go to the directory which contains current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Current directory: $SCRIPT_DIR"
echo

# 2. Show git status of directory ~/.config/NvChad
echo "Git status of ~/.config/NvChad:"
echo "================================"
if [ -d ~/.config/NvChad ]; then
    cd ~/.config/NvChad
    git status
    cd "$SCRIPT_DIR"
else
    echo "Error: ~/.config/NvChad directory does not exist!"
    exit 1
fi
echo

# 3. Prompt to user to ask whether to continue
read -p "Do you want to continue? (y/N): " continue_choice
if [[ ! "$continue_choice" =~ ^[Yy]$ ]]; then
    echo "Script terminated by user."
    exit 0
fi

# 4. Get commit message and handle ~/.config/NvChad
read -p "Enter git commit message: " commit_message
if [ -z "$commit_message" ]; then
    echo "Error: Commit message cannot be empty!"
    exit 1
fi

echo
echo "Working on ~/.config/NvChad..."
cd ~/.config/NvChad

# Check if it's a git repository
if [ ! -d .git ]; then
    echo "Error: ~/.config/NvChad is not a git repository!"
    exit 1
fi

# Git add all, commit and push for NvChad
git add .
if git commit -m "$commit_message"; then
    echo "Committed changes to NvChad config"
    if git push; then
        echo "Successfully pushed NvChad config"
    else
        echo "Error: Failed to push NvChad config"
        exit 1
    fi
else
    echo "No changes to commit in NvChad config"
fi

# 5. Go back to script directory and git add current directory
cd "$SCRIPT_DIR"
echo
echo "Working on current directory ($SCRIPT_DIR)..."

# 6. Git add current directory
git add .

# 7. Git commit with the same message and push
if git commit -m "$commit_message"; then
    echo "Committed changes to current project"
    if git push; then
        echo "Successfully pushed current project"
    else
        echo "Error: Failed to push current project"
        exit 1
    fi
else
    echo "No changes to commit in current project"
fi

echo
echo "Script completed successfully!"
