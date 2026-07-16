Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Git Branch Safety

**Never commit directly on `main` unless explicitly told to do so.**

- Before committing, check the current branch.
- If on `main`, create or ask to create a new branch before making commits.
- Prefer opening a pull request instead of pushing directly to `main`.
- Only commit on `main` when the user explicitly instructs you to commit on `main`.

## 5b. No Admin Merge Bypass

**Never use admin privileges to bypass review / branch protection and force-merge a PR.**

- Do not run `gh pr merge --admin` or any equivalent admin override.
- Do not use GitHub UI "Merge without waiting for requirements to be met".
- Do not disable, skip, or weaken required checks/reviewers to force a merge.
- Do not self-approve + immediately merge your own PR to satisfy protection.
- If merge is blocked, stop and report the blocker. Wait for real review/checks.
- Incident hotfixes may patch live systems temporarily, but Git still lands via a normal reviewed PR. Urgency is not an exception.

## 6. Shell Quoting for Markdown and PR Bodies

**Never put Markdown containing backticks inside a double-quoted shell argument.**

Failure mode to avoid:
- I ran `gh pr edit --body "... show `未开始` ..."`.
- Because the argument was double-quoted, zsh still treated backticks as command substitution.
- The shell tried to execute `未开始`, producing `zsh: command not found: 未开始` and risking a malformed PR body.

Rules:
- For `gh pr create/edit --body` or any shell command containing Markdown/code spans, prefer a single-quoted body.
- If the body may contain single quotes, use a temp file or heredoc-style file creation outside the command, then pass `--body-file`.
- Before blaming `gh` or GitHub formatting, check whether the shell interpreted characters first: backticks, `$()`, `$VAR`, `!`, and quotes.
- When fixing a formatting mistake, verify the rendered/returned body with `gh pr view --json body --jq .body` if correctness matters.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
