---
name: tdd
allowed-tools: Bash(ls:*), Bash(cd:*), Bash(cat:*), Bash(ast-grep:*), Bash(find:*), Read, Glob, Grep, LSP, Write
description: >
  Implement features using Kent Beck's Test-Driven Development (TDD) methodology. Use this skill when the user asks to write code via TDD, follow the Red-Green-Refactor cycle, or build a feature test-first. Guides the workflow of building a test list, writing one failing test at a time, making it pass with minimal production code, and refactoring before moving to the next test.
---

Implement using Kent Beck's TDD.

### Procedure

1. Identify the test scenarios that should be covered and compile them into a list (the test list).
2. Pick "only one" item from the test list, translate it into actual, concrete, executable test code, and confirm that the test fails.
3. Change the production code so that the test you just wrote (and all tests written so far) passes. Add anything you notice during this process to the test list.
4. Refactor as needed to improve the implementation design.
5. Return to step 2 and repeat until the test list is empty.

Steps 2 through 4 are also called the "Red-Green-Refactor cycle."

### Note: Red-Green-Refactor Cycle:

- RED: Write a test and confirm that it fails.
- GREEN: Make the minimal implementation needed for the test to pass.
- REFACTOR: Improve the code and confirm that the tests still pass.
