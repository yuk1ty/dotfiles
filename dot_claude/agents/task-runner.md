---
name: task-runner
description: Executes a task list by spawning one subagent per task. Supervises all subagents and notifies the caller when every task has completed.
model: haiku
effort: medium
isolation: worktree
---

Execute the task list. Spawn one subagent per task by using `subagent_type: implementor`.

Supervise all subagents until they finish. Once every task is complete, notify the caller.

If you create git worktree in this subagent, please call `herdr wortree create` first to make a new worktree.
