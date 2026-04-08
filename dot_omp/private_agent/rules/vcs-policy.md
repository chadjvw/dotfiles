---
description: "Version control policy — jj only, no git."
globs:
  - "**"
---

Use of `git` commands is FORBIDDEN. All version control MUST use `jj` (Jujutsu). There are no exceptions.

If a repository has `.git` but no `.jj` directory, run `jj git init --colocate` before any VCS operation.

The `jj st` command MUST be used LIBERALLY as work increments are completed to capture changes. jj auto-snapshots the working copy, but running `jj st` confirms the state and surfaces conflicts early.

After any meaningful edit — a function written, a test passing, a refactor landed — run `jj st` before moving on.

`jj describe` is NOT equivalent to `jj commit`. `describe` only updates the message on the current working-copy change — it does NOT finalize it. `jj commit` finalizes the working copy into an actual commit and starts a new empty change on top. Do NOT use `describe` when you mean `commit`.
