---
description: Self-review before PR - lint, types, common mistakes, generate PR description
---

Pre-flight check before opening a PR.

## Step 1: Identify What's Changed


```bash
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

git branch --show-current

git diff $DEFAULT_BRANCH --stat
git diff $DEFAULT_BRANCH --name-only

git log main..HEAD --oneline
```

## Step 2: Check for type errors

```bash
yarn tsc --noEmit
```

## Step 3: Check for Common Mistakes

Scan changed files for:

```bash
# Console.logs (should be removed)
git diff main --unified=0 | rg "^\+" | rg "console\.(log|debug|info)" || echo "✓ No console.logs"

# 'any' type annotations
git diff main --unified=0 | rg "^\+" | rg ": any" || echo "✓ No 'any' casts"

# TODO/FIXME added
git diff main --unified=0 | rg "^\+" | rg "TODO|FIXME" || echo "✓ No new TODOs"

# Commented-out code
git diff main --unified=0 | rg "^\+.*//.*[a-zA-Z]+\(" | head -10 || echo "✓ No suspicious commented code"

# Large files added
git diff main --stat | rg "\d{4,} \+" || echo "✓ No large file additions"

# .env or secrets
git diff main --name-only | rg "\.env|secret|password|token|key" || echo "✓ No secrets files"
```

## Step 4: Review the Diff

Use the `reviewer` subagent to analyze the actual code changes:

```
Task(
  subagent_type="reviewer",
  description="Review diff for PR",
  prompt="Review the changes between main and HEAD. Look for:
  - Logic errors
  - Missing error handling
  - Security issues
  - Performance concerns
  - API contract changes
  
  Be harsh but fair. Output a list of concerns if any."
)
```

## Step 5: Generate PR Description

Based on the changes, generate a PR description:

```markdown
## Summary
[1-3 bullet points on what this PR does]

## Changes
- [Key change 1]
- [Key change 2]


## Step 6: Final Checklist

```markdown
## Pre-PR Checklist

- [ ] No type errors
- [ ] No console.logs
- [ ] No 'any' casts (or justified)
- [ ] No secrets committed
- [ ] PR description written
```

