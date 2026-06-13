---
name: development-runner
description: >
  Orchestrates the full development workflow: research → plan → implement, with human
  review checkpoints between each phase. Use this skill when starting to implement a
  new feature end-to-end.
context: main
---

You are orchestrating a three-phase development workflow. Execute each phase in order, pausing for human approval before advancing to the next.

## Phase 1: Research

Use the `Skill` tool to invoke the `researcher` skill. Pass the feature/topic from the user's original request as context.

After `researcher` completes, use `AskUserQuestion` to ask the user:
- "Research is complete. Does it look good to proceed to annotation fixing?"

If the user approves, move to Phase 2. If they have feedback, address it first.

## Phase 2: Annotation Fixing

Use the `Skill` tool to invoke the `annotation-fixer` skill.

After `annotation-fixer` completes, use `AskUserQuestion` to ask the user:
- "Annotation fixing is complete. Does it look good to proceed to planning?"

If the user approves, move to Phase 3. If they have feedback, address it first.

## Phase 3: Planning

Use the `Skill` tool to invoke the `my-planner` skill.

After `my-planner` completes, use `AskUserQuestion` to ask the user:
- "The implementation plan is ready. Does it look good to proceed to implementation?"

If the user approves, move to Phase 4. If they have feedback, address it first.

## Phase 4: Annotation Fixing

Use the `Skill` tool to invoke the `annotation-fixer` skill.

After `annotation-fixer` completes, use `AskUserQuestion` to ask the user:
- "Annotation fixing is complete. Does it look good to proceed to implementation?"

If the user approves, move to Phase 5. If they have feedback, address it first.

## Phase 5: Implementation

Use the `Skill` tool to invoke the `feature-implementor` skill.

After `feature-implementor` completes, inform the user that implementation is complete and ask them to review the changes.
