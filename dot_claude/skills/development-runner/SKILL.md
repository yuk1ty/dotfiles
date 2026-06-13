---
name: development-runner
description: >
  Orchestrates the full development workflow: research → plan → implement, with human
  review checkpoints between each phase. Use this skill when starting to implement a
  new feature end-to-end.
context: main
---

You are orchestrating a four-phase development workflow. Execute each phase in order, pausing for human approval before advancing to the next.

## Phase 1: Research

Use the `Skill` tool to invoke the `researcher` skill. Pass the feature/topic from the user's original request as context.

After `researcher` completes, follow the **Annotation Review** procedure below, then move to Phase 2.

## Annotation Review Procedure

Use this procedure after Phase 1 and Phase 2 complete.

1. Use `AskUserQuestion` to tell the user: "Please review the output. If you have any feedback, add `// ANNOT: <your comment>` annotations to the document, then let me know."
2. Once the user confirms they are done reviewing, use `AskUserQuestion` to ask: "Would you like to run annotation-fixer to apply your annotations, or skip?"
   - If the user chooses to run: invoke the `annotation-fixer` skill, then proceed to the next phase.
   - If the user chooses to skip: proceed to the next phase directly.

## Phase 2: Planning

Use the `Skill` tool to invoke the `my-planner` skill.

After `my-planner` completes, follow the **Annotation Review** procedure above, then move to Phase 3.

## Phase 3: Implementation

### Step 3-1: Task Decomposition

Use the `Agent` tool to spawn a subagent with the following prompt:

> Read the implementation plan from `.claude/user/plan/`. Analyze each step and identify which tasks can run in parallel (no shared files, no logical dependency between them) and which must run sequentially. Output the result as `.claude/user/plan/task-graph.md`, listing tasks grouped into sequential stages and parallel batches within each stage.

### Step 3-2: Task Execution

After the decomposer subagent completes, use the `Agent` tool to spawn a subagent with the following prompt:

> Read the task graph from `.claude/user/plan/task-graph.md`. Execute each task unit using the `Agent` tool:
> - For tasks within a parallel batch: spawn all their agents simultaneously.
> - For sequential stages: wait for all agents in the current stage to finish before starting the next.
>
> Each agent implements its assigned task using TDD (Red-Green-Refactor), touching only the files listed for that task.

After all task agents complete, inform the user that implementation is complete and ask them to review the changes.
