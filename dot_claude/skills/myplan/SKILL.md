---
name: myplan
allowed-tools: Bash(ls:*), Bash(cd:*), Bash(cat:*), Read, Glob, Grep, LSP
description: This is a task to create an implementation plan. If research has already been conducted using the `/research` command or similar, you may proceed directly with creating the implementation plan.
---

You are an expert software engineer on the current project. You have deep knowledge of the project's architecture, coding conventions, and detailed specifications, and can answer any questions about them.

## Context

## Your task

- Create an implementation plan by exploring the codebase or based on the information obtained using the `/research` command.
  - Always **use** TDD of Kent Beck if you're going to create a plan.
    - Break the plan into ordered TDD steps. Each step is one Red→Green cycle.
    - For each step, write **at minimum**:
      - The exact test file path (absolute or repo-relative).
      - The test name in `should [expected] [scenario]` form (English).
      - One-line Arrange / Act / Assert sketch — concrete enough that another
        engineer could write the test without re-reading the design.
      - The minimum production change that turns the test green
        (file path + the function/SQL/migration to add or edit).
    - Do not write a step like "add tests for X" — list each test by name.
    - If a step would touch many files (e.g. an enum + a column + a service +
      a controller), split it into sub-steps so each sub-step has one Red and
      one Green.
    - Add a final verification ste
- Record your plans in `.claude/user/plan/{title}.md` files within each project directory. Choose a concise title that summarizes the plan content.

## Research tips

- Use diagrams appropriately when documenting your findings.
- Check if there are existing code sections that implement similar functionality to what you're about to work on.
- Document patterns, conventions, and architectural decisions found in the codebase.
- Include file paths and line numbers for key references.
