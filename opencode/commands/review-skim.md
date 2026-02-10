
---
description: PR skim review (10s, git only)
agent: review
---

CRITICAL OUTPUT RULES (must follow):
- DO NOT explain reasoning, planning, or process.
- DO NOT repeat these rules or any tool labels.
- DO NOT run any tools (no Read, no Bash). Use only the context below.

FORMAT (exact):
1) One line: "Understanding: <single factual sentence about intent only>"
2) Then exactly these four sections, in this order: Blockers, Risks, Questions, Tests
3) Each section:
   - Either "None"
   - Or 1–N bullets starting with "- "

BULLET RULES:
- Every bullet MUST be formatted as: "- <path>: <concrete failure mode>"
+ Every bullet MUST be formatted as:
+ "- [P0|P1|P2] <path>: <concrete failure mode>"

+ Priority meanings:
+ - P0 = blocking (breaks build, tests, deploy, or correctness)
+ - P1 = high risk (security, data loss, behavior change)
+ - P2 = low risk (edge cases, maintainability, clarity)


Base branch argument: $1 (default main)
Commit window argument: $2 (number of recent commits; default = all)

Resolve base:
!`BASE="$1"; [ -n "$BASE" ] || BASE=main; \
  if git show-ref --verify --quiet "refs/heads/$BASE"; then echo "RESOLVED_BASE=$BASE"; \
  elif git show-ref --verify --quiet "refs/remotes/origin/$BASE"; then echo "RESOLVED_BASE=origin/$BASE"; \
  else echo "RESOLVED_BASE=BASE_NOT_FOUND:$BASE"; fi`

Determine diff range:
!`BASE="$1"; [ -n "$BASE" ] || BASE=main; \
  N="$2"; \
  if [ -n "$N" ]; then \
    echo "RANGE=HEAD~$N..HEAD"; \
  else \
    if git show-ref --verify --quiet "refs/heads/$BASE"; then echo "RANGE=$BASE...HEAD"; \
    elif git show-ref --verify --quiet "refs/remotes/origin/$BASE"; then echo "RANGE=origin/$BASE...HEAD"; \
    else echo "RANGE=UNKNOWN"; fi; \
  fi`

Targeted hunks (respects commit window):
!`BASE="$1"; [ -n "$BASE" ] || BASE=main; \
  N="$2"; \
  if [ -n "$N" ]; then RANGE="HEAD~$N..HEAD"; \
  elif git show-ref --verify --quiet "refs/heads/$BASE"; then RANGE="$BASE...HEAD"; \
  elif git show-ref --verify --quiet "refs/remotes/origin/$BASE"; then RANGE="origin/$BASE...HEAD"; \
  else exit 0; fi; \
  git diff --name-only $RANGE \
  | grep -E '\.(ts|tsx|js|jsx|mjs|cjs|json|sql)$' \
  | grep -vE '^(yarn\.lock|package-lock\.json|pnpm-lock\.yaml)$' \
  | grep -vE '(^|/)(dist|build|coverage)/' \
  | sed -n '1,18p' \
  | while IFS= read -r f; do \
      printf "\n### %s\n" "$f"; \
      git diff --unified=0 $RANGE -- "$f" | sed -n '1,90p'; \
    done \
  | sed -n '1,360p'`

OUTPUT (start immediately, no preamble):

Understanding: <single factual sentence describing intent only>

Blockers:
None

Risks:
None

Questions:
None

Tests:
None
