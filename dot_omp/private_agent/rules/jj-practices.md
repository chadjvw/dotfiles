---
description: "Jujutsu (jj) version control — use jj for all VCS operations instead of git. Colocated mode, command mappings, workflow practices."
globs:
  - "**"
---

## Core Principle

Use `jj` for ALL version control operations. Do NOT use `git` commands directly — even in colocated repos where `.git` exists alongside `.jj`. Jujutsu manages the git backend; direct git mutations risk state divergence.

## Commit Discipline

You MUST commit at logical steps. A "logical step" is any self-contained unit of work: a function written, a bug fixed, a refactor completed, a test added, a config changed. Do NOT accumulate unrelated changes in a single working copy.

You MUST run `jj describe -m "<message>"` immediately after completing each unit of work. The description MUST follow Conventional Commits format. An undescribed change is an unnamed variable — unacceptable.

You MUST run `jj commit -m "<message>"` to finalize the current change and start a new one when moving to the next logical step. This is NOT optional. Failing to commit between logical steps produces tangled history that is painful to review and impossible to bisect.

You MUST run `jj st` after every meaningful edit to confirm the working copy state. This is cheap and catches problems early.

### Commit cadence examples

- Wrote a new function + its tests → `jj commit -m "feat(storage): Add get_by_status query"`
- Fixed a bug → `jj commit -m "fix(handler): Handle missing gateway_id"`
- Refactored imports → `jj commit -m "refactor: Clean up unused imports"`
- Updated config → `jj commit -m "chore: Update DDB table name default"`
- Added a dependency → `jj commit -m "chore(deps): Add chrono for timestamp handling"`

Do NOT batch these together. Each gets its own commit.

## Commit Messages

ALL commit messages MUST follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <subject line>

[optional body]

[optional footer(s)]
```

Types: feat, fix, docs, style, refactor, perf, test, chore, ci

- Imperative mood ("add" not "added")
- No period at end of subject
- Subject line ≤ 50 characters
- Capitalize the subject line
- Body wrapped at 72 characters
- Body explains what and why, not how

## Command Mappings

| Instead of (git)              | Use (jj)                          |
|-------------------------------|-----------------------------------|
| `git status`                  | `jj status` / `jj st`            |
| `git diff`                    | `jj diff`                        |
| `git diff --cached`           | `jj diff -r @`                   |
| `git log`                     | `jj log`                         |
| `git log --oneline`           | `jj log --no-graph -T builtin_log_oneline` |
| `git add . && git commit`     | `jj commit -m "msg"` (auto-tracks all files) |
| `git commit --amend`          | `jj describe -m "msg"` (edits current change description) |
| `git branch`                  | `jj bookmark list`               |
| `git checkout <branch>`       | `jj new <bookmark>`              |
| `git checkout -b <branch>`    | `jj new -m "msg"` then `jj bookmark set <name> -r @` |
| `git stash`                   | Not needed — jj auto-commits working copy |
| `git rebase -i`               | `jj rebase -r` / `jj rebase -s` / `jj squash` |
| `git merge`                   | `jj new <a> <b>` (creates merge commit) |
| `git blame <file>`            | `jj file annotate <file>`        |
| `git show <rev>`              | `jj show <rev>`                  |
| `git push`                    | `jj git push`                    |
| `git fetch`                   | `jj git fetch`                   |
| `git pull`                    | `jj git fetch` then `jj rebase -d <bookmark>@origin` |

### Push options

`jj git push` supports `--option` / `-o` to pass push options to the remote server:

```bash
jj git push --bookmark my-feature -o push.pushOption=value
```

## Key Concepts

- **No staging area.** jj snapshots the working copy automatically. Every change to a tracked file is part of the current change.
- **Working copy is a commit.** `@` always refers to the current working-copy change. It is a real commit, not a dirty state.
- **Changes vs commits.** jj tracks changes by change ID (short hex), not commit hash. Use change IDs in revsets when possible.
- **Immutable history.** Pushed bookmarks are immutable by default. Rewrite only local, unpushed changes.

## Workflow

### Starting new work

```bash
jj new main -m "feat: description of work"
jj bookmark set my-feature -r @
```

### Describe after every unit of work

```bash
# You just finished something. Describe it NOW.
jj describe -m "feat(scope): what you just did"
jj st  # confirm state
```

### Finalize and move to next step

```bash
# Done with this logical change. Commit and start fresh.
jj commit -m "feat(scope): what you just did"
# @ is now a new empty change on top. Continue working.
```

### Splitting changes

```bash
jj split              # interactively split current change
```

### Squashing

```bash
jj squash             # squash current change into parent
jj squash --into <rev>  # squash into a specific revision
```

### Advancing bookmarks

```bash
jj bookmark advance my-feature  # move bookmark forward to @ (default target)
```

Replaces the community `jj tug` alias. Customizable via `revsets.bookmark-advance-from` and `revsets.bookmark-advance-to`.

### Rebasing

```bash
jj rebase -d main     # rebase current change onto main
jj rebase -s @ -d main  # rebase current change and descendants onto main
```

Use `--simplify-parents` on `jj rebase` to automatically remove redundant parent edges after rebasing.

### Syncing with remote

```bash
jj git fetch
jj rebase -d main@origin
jj git push --bookmark my-feature
```

### Resolving conflicts

```bash
jj status             # shows conflicted files
# Edit conflicted files (conflict markers are jj-style, not git-style)
jj resolve            # or just edit and let jj snapshot
jj status             # verify conflicts resolved
```

## Pager Behavior

jj respects `$PAGER`. For non-interactive use, pass `--no-pager`:

```bash
jj --no-pager log
jj --no-pager diff
jj --no-pager show
```

## Safety Rules

1. **Never use raw git commands** in a jj-managed repo. State divergence is painful to recover from.
2. **Never force-push bookmarks** that others have fetched.
3. **Do not modify `.jj/` internals directly.**
4. If jj and git state diverge, run `jj git import` to re-sync jj from git, or `jj git export` to push jj state to git.
5. **Do not use `jj op undo`** — it no longer exists. Use `jj op revert` or `jj undo`/`jj redo` instead.
6. **Use `jj util snapshot`** for manual snapshots, not `jj debug snapshot`.

## Revset Tips

- Bookmarks containing consecutive `--` (e.g. `foo--bar`) no longer need quoting in revsets. Write `jj diff -r foo--bar` directly.
- Pattern aliases are supported: e.g. `'grep:x' = 'description(regex:x)'` in revsets and templates.