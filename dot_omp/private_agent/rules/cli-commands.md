---
description: "CLI tool overrides — use fd instead of find, rg instead of grep, sd instead of sed."
globs:
  - "**"
---

ALWAYS use `fd` instead of `find`, `rg` instead of `grep`, `sd` instead of `sed`.

## Quick Reference

### fd (replaces find)
- Regex by default, not glob: `fd 'pattern'` not `find . -name 'pattern'`
- Searches recursively from cwd by default — no `.` needed
- Respects `.gitignore` automatically
- `-e ext` for extension filter: `fd -e ts`
- `-t f` files only, `-t d` dirs only
- `-H` to include hidden files, `-I` to skip gitignore

### rg (replaces grep)
- Recursive by default, no `-r` needed
- Respects `.gitignore` automatically
- `-t type` for filetype: `rg pattern -t ts`
- `-l` list matching files only
- `-F` for fixed/literal strings (no regex)
- `--no-heading` for machine-parseable output

### sd (replaces sed)
- Uses regex, not sed's BRE/ERE syntax
- No delimiters needed: `sd 'from' 'to' file`
- Capture groups use `$1` not `\1`
- Reads stdin if no file given: `cat f | sd 'a' 'b'`
