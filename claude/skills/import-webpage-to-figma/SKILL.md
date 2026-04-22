---
name: import-webpage-to-figma
description: Use this skill when you need to capture a live webpage in specified viewport sizes and UI states and import it into Figma through MCP.
---

# Import Webpage to Figma

## When to use this skill

Use this skill when the user wants to:

- import a live webpage into Figma
- capture one or more page states
- capture desktop and/or mobile versions
- capture overlays like mobile menu, modal, filter panel, dropdown, popup
- send the result into a specific Figma file

This skill is for transfer and import only. It is not for design system generation.

## What this skill does

Version 1 supports:

- a provided page URL
- a provided Figma file URL
- one or more requested frames
- explicit viewport sizes
- default and overlay UI states
- multi-frame capture in one run

## What this skill does not do

Version 1 does not:

- create styles
- create variables
- create components
- normalize auto layout
- redesign the page
- improve the UI
- extract a design system
- rename layers semantically unless absolutely required by the Figma import workflow

## Supported capture types

- desktop default: desktop viewport in the default loaded state
- mobile default: mobile viewport in the default loaded state
- desktop overlay state: desktop viewport after a requested interaction opens an overlay
- mobile overlay state: mobile viewport after a requested interaction opens an overlay
- multi-frame capture: multiple viewport and state captures in one request

## Required inputs

Minimum required inputs:

- webpage URL
- target Figma file URL
- at least one frame request with viewport size

Optional input:

- state or action request such as open mobile menu, open modal, open filters, open dropdown

## Request normalization

Normalize the user request into a simple internal capture plan with:

- page URL
- target Figma file
- requested frames
- viewport width
- viewport height if provided
- state type
- optional actions before capture

## Execution rules

1. Read the requested page URL and Figma file URL.
2. Identify all requested frames and viewport sizes.
3. For each frame, open the webpage in the correct viewport.
4. Wait for the page to stabilize before capture.
5. If a requested state requires interaction, perform the necessary action first.
6. Capture each final state separately.
7. Hand off the final prepared capture to the installed Figma MCP skill/workflow for actual import into Figma.
8. Keep each imported result as a separate frame.
9. Do not perform design cleanup or systemization.

## Viewport rules

- always use explicitly requested viewport sizes
- do not guess alternative viewport widths if the user already specified them
- if no height is provided, use a sensible default viewport height only for capture preparation
- preserve requested desktop/mobile separation

## State capture rules

- default state means the page as loaded after stabilization
- overlay state means a user-triggered UI state before capture
- only capture requested states
- do not invent additional states
- treat menu, modal, drawer, dropdown, filters, popup as valid overlay states

## Multi-frame rules

- one request may produce multiple Figma frames
- each requested viewport/state combination should be imported separately
- keep naming clear and functional

## Frame naming rules

- Desktop 1440
- Mobile 390
- Mobile Menu 390
- Desktop Filters Open 1440

## Dependency boundary

This skill is an orchestration layer.

It prepares webpage states and capture conditions.

It depends on the installed Figma MCP skill or workflow for the final import step.

It should not attempt to replace official Figma import capabilities.

## Output expectations

The expected output is:

- one or more imported Figma frames
- corresponding to the requested viewports and states
- transferred as-is from the live webpage state
- without design-system construction

## Examples

Example 1:
Import https://example.com into this Figma file:
https://figma.com/file/ABC
Frames:
- Desktop 1440
- Mobile 390

Example 2:
Import https://example.com/product into this Figma file:
https://figma.com/file/ABC
Frames:
- Mobile 390
- Mobile menu open 390

Example 3:
Import https://example.com/catalog into this Figma file:
https://figma.com/file/ABC
Frames:
- Desktop 1920
- Desktop filters open 1920
- Mobile 390
