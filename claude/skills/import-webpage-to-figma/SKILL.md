---
name: import-webpage-to-figma
description: Captures a live webpage and imports it into a Figma file as editable frames at an exact viewport width. Use when user asks to "import this site into Figma", "capture webpage to Figma", "send live UI to Figma", "import webpage", "scrape a site into Figma", "convert webpage to Figma frames", or provides a Figma file URL together with a site URL and a viewport size. One viewport per run.
license: MIT
compatibility: Requires Claude Code with Figma MCP server (figma@claude-plugins-official) and Playwright MCP. Uses the official generate_figma_design tool and the public Figma capture.js script. Does not work without Figma MCP authentication.
metadata:
  author: Vasyl
  version: 1.0.0
  target: claude-code
  category: design-handoff
  tags: [figma, webpage-capture, playwright, mcp, code-to-canvas]
---

# Import Webpage to Figma

Capture a live webpage at an exact viewport width and import it into a target Figma file as editable frames.

The skill orchestrates Figma's official `generate_figma_design` MCP tool with Playwright. It does not perform any post-import design work — captured frames are imported as-is.


# Required environment

Before running, the following must be configured:

- Claude Code installed and running in the terminal
- Figma MCP server connected and authenticated: `claude plugin install figma@claude-plugins-official`, then `/mcp` to verify `figma` is connected
- Playwright MCP available (used to open the page and inject the capture script)
- Edit access to the target Figma file


If `/mcp` does not list `figma` as connected, stop and ask the user to authenticate before continuing.


# Input format

The user must provide three values together:

```
Figma: https://www.figma.com/design/FILE_KEY/...
Site:  https://example.com
Viewport: Desktop 1440
```

Field rules:

- `Figma` — full Figma file URL with FILE_KEY (or empty to create a new draft file)
- `Site` — full webpage URL including protocol (`https://`)
- `Viewport` — device label + exact pixel width, separated by space


Allowed viewport labels: `Desktop`, `Tablet`, `Mobile`. The pixel width must be an integer.


If any field is missing, ambiguous, or the viewport width is not a clean integer, stop and ask the user to provide the missing value. Do not guess.


# Execution

1. Verify Figma MCP is connected. If not, stop and instruct the user to authenticate.
2. Call the official `generate_figma_design` tool with the Site URL and the target Figma file URL (or no URL if the user wants a new draft file). This is the entry point for code-to-canvas.
3. The Figma MCP will return either a browser link to follow or instructions to inject the capture script. If the flow requires Playwright:
   - Open the Site URL in Playwright at the exact requested viewport width (no scaling, no DPR override unless the user asks).
   - Wait for the page to load fully and stabilize (network idle + main content rendered).
   - Inject the Figma capture script (`https://mcp.figma.com/mcp/html-to-design/capture.js`) and trigger `captureForDesign()`.
4. The capture toolbar / script delivers the frame to the specified Figma file.
5. Name the imported frame: `{Device} {Width}` — e.g. `Desktop 1440`, `Mobile 390`. The device label and width come directly from the user's `Viewport` input.


After the frame is delivered to Figma, the run is complete.


# Scope rules

The skill performs capture only. It must NOT:

- run design cleanup
- create components or instances
- apply auto layout
- rename or restructure layers
- import multiple viewports in one run
- attempt to capture overlays, hover states, or modals (the capture is a single static snapshot of the current viewport)


If the user asks for any of the above in the same prompt, capture first, then explicitly state that the additional work is out of scope for this skill.


# Limitations

- One viewport per prompt. For desktop + mobile, run two separate prompts back-to-back.
- Full-page-at-current-viewport capture only. The capture grabs whatever is visible at the configured viewport width. Individual components, hover states, and overlays are not supported.
- Sites with strict Content Security Policy (CSP) may block the injected `capture.js` script. The script can fail silently — see Troubleshooting.
- Authentication-gated content requires the user to be logged in within the Playwright session before capture is triggered.
- After the Playwright + capture flow completes, the terminal session may appear to hang on a long-running browser process. This is expected. The user can press Ctrl+C in the terminal once the frame is confirmed in Figma.


# Examples

## Example 1: Standard desktop capture into existing file

User input:

```
Figma: https://www.figma.com/design/abc123/Landing-Audit
Site: https://stripe.com
Viewport: Desktop 1440
```

Actions:

1. Verify Figma MCP is connected.
2. Call `generate_figma_design` with `https://stripe.com` and the Figma file URL.
3. Open `https://stripe.com` in Playwright at exactly 1440px width.
4. Wait for stabilization, inject `capture.js`, trigger `captureForDesign()`.
5. Frame delivered to the Figma file as `Desktop 1440`.

Result: One frame in the target Figma file. No further design work.


## Example 2: Mobile capture into a new draft file

User input:

```
Figma: (empty — create new draft)
Site: https://news.ycombinator.com
Viewport: Mobile 390
```

Actions:

1. Verify Figma MCP is connected.
2. Call `generate_figma_design` with the Site URL and no target file → MCP creates a new draft.
3. Open the site in Playwright at 390px width.
4. Inject capture script, trigger capture.
5. Frame delivered to a new draft file as `Mobile 390`.

Result: New draft Figma file with one frame named `Mobile 390`.


## Example 3: Two viewports — must be two runs

User input:

```
Figma: https://www.figma.com/design/abc123/Landing-Audit
Site: https://stripe.com
Viewport: Desktop 1440 + Mobile 390
```

Actions:

1. Stop and explain: this skill captures one viewport per run.
2. Suggest the user run two separate prompts back-to-back, each with one viewport value.

Result: No capture in this run. User runs the skill twice.


## Example 4: Missing field

User input:

```
Site: https://stripe.com
Viewport: Desktop 1440
```

Actions:

1. Stop. The `Figma` field is missing.
2. Ask: "Please provide the target Figma file URL, or write `new draft` to create a new file."

Result: No capture until the user resolves the input.


# Troubleshooting

## Figma MCP not connected

Cause: User has not installed the Figma plugin or has not authenticated.

Solution: Instruct the user to run `claude plugin install figma@claude-plugins-official`, then `/mcp` → select `figma` → Authenticate. Restart Claude Code if the server does not appear.


## Capture toolbar never appears on the page

Cause: The site's Content Security Policy blocks external script injection. Common on enterprise tools, banking sites, and some SaaS dashboards.

Solution: This is a hard limitation of the capture flow. The skill cannot bypass CSP. Inform the user and suggest capturing a public-facing or staging version of the same UI.


## Frame in Figma is empty or partial

Cause: Page was not fully loaded when capture was triggered, or capture ran before lazy-loaded content rendered.

Solution: Re-run with extra wait time. If the page has heavy lazy-loading, ask the user to confirm the viewport content is fully visible before capture is triggered.


## Authentication-gated page returns login screen

Cause: Playwright session is not authenticated against the target site.

Solution: Capture skill cannot log in on the user's behalf. Ask the user to authenticate manually inside the Playwright browser window (when the flow opens it), then re-trigger capture.


## Terminal hangs after capture is complete

Cause: Long-running browser/Playwright process stays alive after capture delivers the frame.

Solution: Expected behavior. Once the frame is confirmed in the Figma file, the user can press Ctrl+C in the terminal to exit. This is not a failure.


## User asks for hover/modal/scroll state

Cause: Skill captures a single static viewport.

Solution: Out of scope. Capture as-is, then state that hover/modal/scroll states require manual interaction in the browser before capture (and even then, results are inconsistent — Figma's capture is designed for static page state).


## Frame name does not match user's Viewport input

Cause: Skill applied a different label than the user provided.

Solution: The frame name must be exactly `{Device} {Width}` from the user's `Viewport` field. If the user wrote `Desktop 1440`, the frame must be named `Desktop 1440` — not `1440`, not `Desktop 1440px`, not anything else.
