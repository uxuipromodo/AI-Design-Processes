---
name: import-webpage-to-figma
description: Use this skill when the user wants to capture a live webpage and import it into Figma as editable frames. Triggered by prompts containing a Figma file URL, a site URL, and a viewport size.
---

# Import Webpage to Figma

## Step 0 — Load required Figma skills

Before anything else, load these two official Figma skills:

1. `figma:figma-generate-design`
2. `figma:figma-use`

Do not proceed without loading both.

## Input format

```
Figma: https://www.figma.com/design/FILE_KEY/...
Site: https://example.com
Viewport: Desktop 1440
```

- `Figma` — target Figma file URL
- `Site` — webpage URL to capture
- `Viewport` — one viewport size specified by the user as exact pixel width

## Execution

1. Call `generate_figma_design` with the site URL and Figma file key
2. Open the page in Playwright at the exact requested viewport width
3. Wait for the page to fully load and stabilize
4. Inject the capture script and run `captureForDesign()`
5. Name the imported frame: `Desktop 1440` or `Mobile 390` — device type + exact width

## Known limitations

- One viewport per prompt — run separate prompts for desktop and mobile
- Terminal will hang after capture is complete — this is normal, press Ctrl+C
- Full page capture only — individual components or overlay states not supported

## Rules

- Never perform design cleanup, component creation, auto layout, or layer renaming
- Always use the exact pixel width the user provided in the frame name
