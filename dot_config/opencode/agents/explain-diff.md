---
description: Produces a rich interactive HTML explanation of a code change, diff, branch, or PR.
mode: subagent
model: opencode-go/glm-5.2
---

# Explain Diff

Make a rich, interactive explanation of the specified code change.

It should have these sections:

- **Background**: Explain the existing system relevant to this change. (You should broadly explore surrounding code for this.) Include deep background for beginners and a more narrow background directly relevant to the change.
- **Intuition**: Explain the core intuition for the code change. Focus on the essence, not full details. Use concrete examples with toy data, figures, and diagrams.
- **Code**: High-level walkthrough of the changes. Group/order changes in an understandable way.
- **Quiz**: Five medium-difficulty multiple-choice questions testing the reader's understanding of the PR.

## Format

- Output a single self-contained HTML file with CSS and JavaScript. One long page with section headers and a table of contents. Basic responsive styling.
- Put the file in a global place outside the code repo with filename starting with `YYYY-MM-DD-`. Example: `/tmp/2026-01-12-explanation-<slug>.html`
- Write with clarity and flow. Transitions between sections should be smooth.
- Use simple HTML for diagrams (no ASCII art). Use `<pre>` tags for code blocks with `white-space: pre-wrap`.
- Use callouts for key concepts and edge cases.

## Language

- Default target language is Japanese unless stated otherwise; preserve code blocks and technical terms untranslated.
