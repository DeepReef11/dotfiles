#!/bin/bash

# Check current GitHub URL configuration
if git config --global --get-regexp "url\.https://github\.com/\.insteadOf" > /dev/null; then
    echo "Switching from HTTPS to SSH for GitHub..."
    git config --global --unset url."https://github.com/".insteadOf "git@github.com:"
    echo "Now using SSH for GitHub repositories"
else
    echo "Switching from SSH to HTTPS for GitHub..."
    git config --global url."https://github.com/".insteadOf "git@github.com:"
    echo "Now using HTTPS for GitHub repositories"
fi
