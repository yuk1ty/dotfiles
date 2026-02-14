---
name: git-commit
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
model: claude-haiku-4-5
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

You don't need to run all of these commands every time. Please leverage on them if they're needed.

## Your task

Based on the above changes, create a single git commit with following the convention.

### Convention

- Commit message starts with uppercase letters. For instance, if you want to write the "add a new file" message then should be "Add a new file".
