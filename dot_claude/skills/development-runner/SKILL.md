---
name: development-runner
description: >
  Orchestrates the full development workflow: research → plan → implement, with human
  review checkpoints between each phase. Use this skill when starting to implement a
  new feature end-to-end.
context: main
model: sonnet
effort: high
---

You are orchestrating a four-phase development workflow. Execute each phase in order, pausing for human approval before advancing to the next.

## Phase 1: Research

Use the `Skill` tool to invoke the `researcher` skill. Pass the feature/topic from the user's original request as context.

After `researcher` completes, follow the **Annotation Review** procedure below, then move to Phase 2.

## Annotation Review Procedure

Use this procedure after Phase 1 and Phase 2 complete. Run the following loop until the user approves.

1. Use `AskUserQuestion` to tell the user: "Please review the output. If you have any feedback, add `// ANNOT: <your comment>` annotations to the document, then let me know. If everything looks good, reply 'approve'."
2. Once the user responds:
   - If the user replies **approve** (or equivalent): exit the loop and proceed to the next phase.
   - Otherwise: invoke the `annotation-fixer` skill to apply the annotations, then return to step 1.

## Phase 2: Planning

Use the `Skill` tool to invoke the `my-planner` skill.

After `my-planner` completes, follow the **Annotation Review** procedure above, then move to Phase 3.

## Phase 3: Implementation

### Step 3-1: Task Decomposition

Use the `Agent` tool with `subagent_type: task-decomposer` to launch the task-decomposer agent. Pass the path to the implementation plan (`.claude/user/plan/`) as context.

### Step 3-2: Task Execution

After the decomposer subagent completes, use the `Agent` tool with `subagent_type: task-runner` to launch the task-runner agent. Pass the path to the task graph (`.claude/user/plan/task-graph.md`) as context.

After all task agents complete, note the worktree branch returned in the `task-runner` result. Run `git checkout <branch>` via the `Bash` tool to switch the current working directory to that branch before proceeding to Phase 4.

## Phase 4: Code Review

Run the following loop until the code-reviewer returns APPROVE:

1. Use the `Agent` tool with `subagent_type: code-reviewer` to review the current changes.
2. If the result is **REQUEST_CHANGES**: apply every finding autonomously, then return to step 1.
3. If the result is **APPROVE**: exit the loop.

Once approved, proceed to Phase 5.

## Phase 5: Document Sync

Use the `Agent` tool to spawn a subagent with the following prompt:

> Compare the actual implementation on the current branch against the documents produced in earlier phases:
> - Research document: `.claude/user/research/`
> - Implementation plan: `.claude/user/plan/`
>
> Identify any discrepancies — features added, removed, or changed during implementation that are not reflected in the documents. For each discrepancy found, update the relevant document to match the actual implementation.
>
> Report a summary of what was updated.

After the subagent completes, inform the user the workflow is complete.
