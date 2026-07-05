---
name: ci-babysit
description: Monitor a PR's CI, re-arm on each iteration, ignore known-flaky errors, stop when green
context: fork
model: haiku
---
1. Ask for the PR number and any errors to ignore.
2. Poll `gh pr checks <num>` until all required checks pass.
3. Re-arm monitor each loop; report status changes.
4. Terminate cleanly when green.
Then run /ci-babysit
