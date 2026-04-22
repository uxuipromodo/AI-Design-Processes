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

Capture each viewport **one at a time**. Never start the next viewport until the current one is fully complete.

### For each viewport — follow these steps exactly:

**Step 1.** Call `generate_figma_design` with the site URL and Figma file key. Receive one captureId. Do not call `generate_figma_design` again until this viewport is fully done.

**Step 2.** Open the site in Playwright at the exact viewport width specified by the user.

**Step 3.** Wait for the page to fully load and stabilize.

**Step 4.** Inject the capture script and call `captureForDesign()`.

**Step 5.** Poll every 5 seconds until status is `"completed"`. Do not proceed until `"completed"` is received.

**Step 6.** Close the Playwright session completely.

**Step 7.** Name the imported frame: `Desktop 1366`, `Mobile 360` — always include device type and exact pixel width.

**Step 8.** Only after Step 7 is confirmed — start the next viewport from Step 1.

### After all viewports are done:

1. Call `use_figma` to verify all requested frames are present in the Figma file
2. Report to the user: which frames were imported, their names, and confirm success
3. If a frame is missing — retry that viewport once

## Rules

- Never capture two viewports at the same time
- Never call `generate_figma_design` for viewport 2 before viewport 1 is fully complete
- Never skip a requested viewport
- Never add viewports the user did not request
- Never perform design cleanup, component creation, auto layout, or layer renaming
- Always use the exact pixel width the user provided in frame names
