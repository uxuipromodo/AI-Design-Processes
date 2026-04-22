---
name: import-webpage-to-figma
description: Use this skill when the user wants to capture a live webpage and import it into Figma as editable frames. Triggered by prompts containing a Figma file URL, a site URL, and one or more viewport sizes.
---

# Import Webpage to Figma

## Step 0 — Load required Figma skills

Before anything else, load these two official Figma skills:

1. `figma:figma-generate-design`
2. `figma:figma-use`

Do not proceed without loading both.

## Input format

The user will always provide:

```
Figma: https://www.figma.com/design/FILE_KEY/...
Site: https://example.com
Viewports: Desktop 1440, Mobile 390
```

- `Figma` — target Figma file URL
- `Site` — webpage URL to capture
- `Viewports` — one or more sizes, always specified by the user as exact pixel widths

## Execution

For each requested viewport, in order:

1. Call `generate_figma_design` with the site URL and Figma file key
2. Set viewport width exactly as specified by the user
3. Wait for page to fully load before capture
4. Import the captured frame into the Figma file
5. Name the frame: `[Device] [Width]` — for example `Desktop 1440`, `Mobile 390`

Repeat for every viewport in the same run.

## After all frames are imported

1. Call `use_figma` to verify all requested frames are present in the Figma file
2. Report to the user which frames were successfully imported with their names
3. If a frame is missing — retry that viewport once before reporting failure

## Rules

- Never skip a requested viewport
- Never add viewports the user did not request
- Never perform design cleanup, component creation, auto layout, or layer renaming
- Always use the exact pixel width the user provided in frame names
