---
description: "Git command intercept — redirects all git usage to jj."
condition: "\\bgit\\b"
scope: "tool:bash"
---

STOP. You MUST NOT use git commands. All version control MUST use `jj` (Jujutsu).

Read `rule://jj-practices` for the full command mapping and workflow reference.

Common translations for whatever you were about to do:

| git command         | jj equivalent                |
|---------------------|------------------------------|
| `git status`        | `jj st`                      |
| `git diff`          | `jj diff`                    |
| `git log`           | `jj log`                     |
| `git add && commit` | `jj commit -m "msg"`         |
| `git commit --amend`| `jj describe -m "msg"`       |
| `git push`          | `jj git push`                |
| `git fetch`         | `jj git fetch`               |
| `git rebase`        | `jj rebase`                  |
| `git blame`         | `jj file annotate`           |
| `git branch`        | `jj bookmark list`           |
| `git show`          | `jj show`                    |

The ONLY acceptable use of `git` is through jj's git subcommand: `jj git fetch`, `jj git push`, `jj git import`, `jj git export`.
