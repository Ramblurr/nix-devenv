---
name: find-screenshots
description: Find user-created screenshot files on this workstation for the agent to inspect. Use when the user asks you to look at a screenshot, find recent screenshots, open a screenshot they captured, or references an image/screenshot without providing a path.
---

# Find Screenshots

## Purpose

Use this skill to find screenshots the user already created. This skill is not for taking new screenshots.

## Quick start

Run the helper script from this skill directory:

```bash
bash find-screenshots.sh     # list 5 latest screenshots
bash find-screenshots.sh 10  # list 10 latest screenshots
```

It prints up to five matching screenshot paths across all existing screenshot directories, newest first.

## Workflow

1. Run the helper script.
2. If the user mentioned "latest" or did not identify a specific screenshot, inspect the newest returned file.
3. If several files may match the request, show the returned paths and ask which one they mean.
4. Open/read the selected image with the available image-capable tool.
