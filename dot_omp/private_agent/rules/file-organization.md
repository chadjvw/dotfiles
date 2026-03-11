---
description: "File and code organization standards — naming conventions, directory structure, workspace hygiene."
condition: "mkdir|touch|new.*file|create.*dir"
scope: "tool:bash, tool:write"
---

## Code Organization

- **Naming Convention Consistency**: Follow language/framework standards (camelCase for JS, snake_case for Python)
- **Descriptive Names**: Files, functions, variables must clearly describe their purpose
- **Logical Directory Structure**: Organize by feature/domain, not file type
- **Pattern Following**: Match existing project organization and naming schemes
- **No Mixed Conventions**: Never mix camelCase/snake_case/kebab-case within same project

## File Organization

- **Think Before Write**: Always consider WHERE to place files before creating them
- **Test Organization**: Place all tests in `tests/`, `__tests__/`, or `test/` directories
- **Script Organization**: Place utility scripts in `scripts/`, `tools/`, or `bin/` directories
- **Check Existing Patterns**: Look for existing test/script directories before creating new ones
- **No Scattered Tests**: Never create test_*.py or *.test.js next to source files
- **No Random Scripts**: Never create debug.sh, script.py, utility.js in random locations
- **Separation of Concerns**: Keep tests, scripts, docs, and source code properly separated

## Workspace Hygiene

- **Clean After Operations**: Remove temporary files, scripts, and directories when done
- **No Artifact Pollution**: Delete build artifacts, logs, and debugging outputs
- **Session End Cleanup**: Remove any temporary resources before ending session
- **Version Control Hygiene**: Never leave temporary files that could be accidentally committed
