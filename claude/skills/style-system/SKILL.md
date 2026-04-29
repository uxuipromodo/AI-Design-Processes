---
name: style-system-builder
description: Extracts, normalizes, extends, and applies typography and color styles from Figma layouts in planning-first mode. Use when user asks to "build a style system", "normalize typography", "audit styles", "extract text styles from Figma", "extract color styles", "clean up the design system", "fix inconsistent styles", "normalize the neutral palette", "merge duplicate styles", "rename legacy styles" (H1, H2, Button, Helper), or mentions style-system audit, typography audit, color audit, scale extension, semantic colors (Success/Error/Warning/Info), or design-to-style-library cleanup in a Figma file, page, frame, or selection.
license: MIT
compatibility: Requires Figma Plugin API runtime with font access. Designed for planning-first audit workflows on files, pages, frames, or selections.
metadata:
  author: Vasyl
  version: 1.0.0
  target: figma-plugin
  category: design-systems
  tags: [typography, color, style-audit, figma, design-system]
---

# Pre-flight: Load References (BLOCKING)

Before starting any phase, load ALL of the following references:

- [ ] `references/audit-principles.md`
- [ ] `references/typography-extraction.md`
- [ ] `references/color-extraction.md`
- [ ] `references/accessibility-validation.md`
- [ ] `references/naming-convention.md`

Do NOT proceed to PHASE 1 until all references are loaded.

---

# Style System Builder

Build a normalized typography and color style system from an existing Figma layout.

Operate in planning mode before applying any changes.

This skill:

- reads styles from the canvas
- detects inconsistencies
- clusters related values
- proposes a system
- extends missing scale steps
- merges palettes with project defaults
- validates accessibility
- asks confirmation
- applies styles only after approval


Reference map:

- Workflow phases, severity model, rename/merge/create order → `references/audit-principles.md`
- Typography detection, role clustering, canonical 2px grid, non-canonical handling → `references/typography-extraction.md`
- Color extraction, neutral/accent/semantic layers, apply safety rules → `references/color-extraction.md`
- Scale extension, gap detection, tonal interpolation, variant completion → `references/scale-extension.md`
- Contrast thresholds, surface hierarchy, semantic and interactive state validation → `references/accessibility-validation.md`
- Full naming formats, legacy rename rules, multi-font namespacing → `references/naming-convention.md`


# Operating Mode

Always run in planning mode.

No styles are created or applied before explicit designer confirmation.


Workflow follows the four-phase audit model:

PHASE 1 — AUDIT
  *(Збираємо всі значення з файлу, виявляємо проблеми. Жодних змін у файлі не відбувається.)*
  IMPORTANT: All data collection (fonts, text sizes, colors, node fills) MUST be done via `use_figma`.
  Do NOT use `get_metadata` or `get_design_context` for audit data collection — they do not provide
  full node-level access. `get_metadata`/`get_design_context` may only be used for quick structural
  orientation if needed, never as the primary audit tool.

PHASE 2 — DESIGNER CONFIRMATION
  *(Показуємо знахідки і пропозиції. Чекаємо рішення дизайнера по кожному пункту. Без підтвердження — нічого не виконується.)*
  IMPORTANT: Accessibility validation is a MANDATORY part of the PHASE 2 preview.
  Before presenting findings to the designer, run a `use_figma` call that:
  1. For each TEXT node, collects its fill color AND the background color of its nearest opaque parent
  2. Calculates contrast ratio for each text/background pair
  3. Flags pairs that fail WCAG thresholds (Body ≥ 4.5:1, Large text ≥ 3:1, UI boundaries ≥ 3:1)
  Include the accessibility report in the PHASE 2 output alongside typography and color findings.
  Do NOT skip accessibility and do NOT present PHASE 2 without it.

PHASE 3 — FINAL VALIDATION
  *(Перевіряємо що підтверджений план без конфліктів. Останній шанс щось скоригувати перед виконанням.)*

PHASE 4 — APPLY CHANGES
  *(Виконуємо зміни у файлі — лише після явного "так" від дизайнера.)*
  Step 4.1 — update style system (rename → merge → delete → create)
  Step 4.2 — apply styles to layout nodes


See `references/audit-principles.md` for:

- full phase rules
- severity model (Critical / Warning / Suggestion)
- issue taxonomy
- designer confirmation model
- final validation checks
- the mandatory rename → merge → delete → create order within Step 4.1


CRITICAL ORDER within Step 4.1:

1. rename existing styles to their normalized target names (ALWAYS first)
2. merge duplicates into a single canonical style
3. delete unused
4. create new styles only for gaps that remain after rename and merge

Never create a new style if an existing style can be renamed to fill that role.

Never apply styles to nodes before the style system is finalized (Step 4.1 must fully complete before Step 4.2 begins).


# Font Availability Guard (BLOCKING)

This is a blocking prerequisite for all typography operations.

Before typography extraction, typography normalization, or text style creation:

- scan all text nodes in the current file
- detect all used font families
- detect all used styles or weights for each family
- verify each detected font family and style is available in Plugin API runtime


If any detected font is unavailable:

stop execution immediately

return:

FONT_CHECK_FAILED

list missing fonts in this format:

Missing fonts:
– {Font Family} / {Style}
– {Font Family} / {Style}


Do not substitute fallback fonts.

Do not continue typography generation.

Do not create text styles.

Do not continue to later phases.


# Supported Output Modes

- Analyze only
- Create styles only
- Create and apply styles


Rules:

- default mode remains planning mode first
- no styles are created before confirmation
- no styles are applied before confirmation
- in Create styles only mode, create styles but do not bind them to nodes
- in Create and apply styles mode, create styles and apply them to matching text and color nodes in the file


# Typography

Typography uses a 2px step grid with semantic role clustering.


Base rhythm:

2px


Roles and default weights:

Heading → Semibold

Body → Regular

Action → Medium

Label → Medium or Regular


Cluster detected styles into semantic roles before naming:

Heading
Body
Action
Label


Do not generate purely numeric text styles unless classification is ambiguous.


Non-canonical sizes (not divisible by 2px) must stop in planning mode with explicit options. Never snap silently.


# Line-Height Rule (ABSOLUTE — no exceptions)

Line-height values are ALWAYS expressed as a percentage or AUTO.

ALLOWED:
- percentage value, e.g. 150%, 137%, 106%
- AUTO

NEVER use pixel values for line-height — not in audit output, not in style names, not in style creation.

If a node has a pixel line-height, convert it to percentage before naming or creating the style:
percentage = round(pixelLineHeight / fontSize * 100)

Example: 16px line-height on 12px font → 16/12*100 = 133%

This rule applies in ALL contexts: audit, planning, naming, style creation.


See `references/typography-extraction.md` for:

- role detection rules per category (Heading / Body / Action / Label)
- canonical scale values and alignment rules
- non-canonical size planning-mode workflow
- size clustering and frequency-based priority
- line-height inference per role
- letter-spacing inference per role
- weight normalization and family handling
- exception handling


See `references/scale-extension.md` for:

- scale gap detection
- role-aware extension
- frequency-aware extension
- line-height and weight completion for new steps


# Color

Color styles are built in three layers:

1. Neutral palette
2. Accent palette
3. Semantic palette


Always normalize Neutral palette first.


Color audit must be node-driven and style-aware. Build the audit color universe from:

1. all styles that exist
2. all actual color values found on nodes


Always scan:

- local paint styles
- imported or foreign style-bound paints present on nodes
- raw fills
- raw strokes
- text fills
- effect colors when present and relevant


Do not skip a color only because it is not wrapped in a local style.


Avoid defaulting to pure black (#000000) or pure white (#FFFFFF) as primary anchors unless explicitly required by the layout.


Ensure baseline semantic colors are present:

Success
Error


Warning and Info are optional — never create them silently; always confirm first.


See `references/color-extraction.md` for:

- extraction targets and role grouping
- neutral palette template and merge rules
- pure black/white handling
- accent clustering and palette consolidation
- semantic palette detection and variant completion
- frequency-based priority
- surface role detection (Background / Surface / Elevated / Overlay)
- border color clustering (Subtle / Default / Strong)
- apply safety rules (SOLID-only, skip VECTOR / GROUP / IMAGE)


See `references/scale-extension.md` for:

- neutral palette extension and tonal interpolation
- accent ladder completion
- semantic variant completion
- surface layer completion


# Apply Safety (Summary)

Apply color styles only to nodes that already contain a semantically valid SOLID fill.


Never auto-apply background color styles to:

- IMAGE / GRADIENT / VIDEO / any non-solid paints
- mixed or multi-fill nodes unless explicitly confirmed
- VECTOR nodes
- BOOLEAN_OPERATION nodes
- GROUP nodes
- frames whose children are only vectors or icons
- nodes whose names indicate logo or icon
- structural auto-layout wrappers (section wrappers, footer columns, menu groupings, etc.)


Preserve image-bearing nodes unchanged.


See `references/color-extraction.md` for the full apply safety rule set and rationale.


# Accessibility

Accessibility validation runs as part of PHASE 2 (before designer confirmation), not just before apply.

Execute via `use_figma`: collect text/background color pairs from actual nodes, calculate contrast ratios,
report violations. Never rely on manually eyeballing color lists — always compute from node data.

validate contrast for primary body text, secondary body text, large headings, and UI component boundaries.


Contrast thresholds:

Body text ≥ 4.5:1
Large text ≥ 3:1
UI boundaries ≥ 3:1


If violations detected: report before applying styles. Offer adjustment suggestions. Never auto-correct silently.


See `references/accessibility-validation.md` for:

- validation scope (text, surfaces, semantic, interactive states, overlays)
- per-role contrast rules (body / heading / label)
- surface hierarchy validation
- border visibility validation
- semantic color distinguishability
- interactive / disabled / overlay / accent validation
- exception reporting format


# Naming Convention

Typography format:

Text/Role/Weight Size-LineHeight

CRITICAL — Figma folder rules:
- Each `/` creates a new folder level in Figma's style panel.
- Do NOT use spaces around `/` — they become part of the folder name.
- Do NOT use `/` between Size and LineHeight — use `-` (hyphen) instead.
- Two `/` separators = two folder levels: Text → Role → style name.

Roles: Heading, Body, Action, Label.


Correct examples:

Text/Heading/Semibold 32-110
Text/Body/Regular 16-150
Text/Action/Medium 14-120
Text/Label/Medium 12-100


Color format:

Color/Layer/Role


Examples:

Color/Neutral/White
Color/Neutral/Gray 500
Color/Accent/Primary
Color/Semantic/Success


NEVER use semantic size suffixes (SM, Base, MD, LG, XS) as the final segment. The `Weight Size-LineHeight` format is the only allowed form for typography.


WRONG:

- `Text/Body/SM` ❌
- `Text/Heading/LG` ❌
- `Text/Action/MD` ❌


Do not generate unnamed styles. Always normalize naming before creation.


See `references/naming-convention.md` for:

- full naming philosophy and structure rules
- multi-font namespacing (Text/UI/… vs Text/Editorial/…)
- weight / line-height / letter-spacing naming policies
- neutral, accent, semantic, surface, and border naming structures
- legacy style renaming rules (H1, H2, Button, Helper, Heading Large, etc.)
- duplicate detection and exception naming
- naming stability rules


# Preview Output Requirements

Before applying any changes, show:

- detected typography scale
- detected grayscale palette
- detected semantic palette
- missing steps
- clustering decisions
- proposed naming
- accessibility warnings
- palette merges
- full rename → merge → delete → create plan (mapped per existing style)


Apply changes only after designer confirmation.


# Examples

## Example 1: Typography audit on an existing file

User says: "Audit the typography in this Figma file."

Actions:

1. Run font availability check on all text nodes (blocking).
2. Read local text styles and actual values used on text nodes.
3. Cluster by role (Heading / Body / Action / Label).
4. Detect non-canonical sizes, duplicates, and missing steps.
5. Build rename/merge/create plan with severity per finding.
6. Present audit report in planning mode.

Result: Structured audit output. No styles modified until designer confirms.


## Example 2: Full style system build from a layout

User says: "Build a style system from this layout and apply it."

Actions:

1. Font availability check (blocking).
2. Typography extraction → role clustering → scale alignment (see `references/typography-extraction.md`).
3. Color extraction → neutral / accent / semantic layers (see `references/color-extraction.md`).
4. Scale extension proposals for gaps (see `references/scale-extension.md`).
5. Accessibility validation (see `references/accessibility-validation.md`).
6. Naming normalization with rename-before-create plan (see `references/naming-convention.md`).
7. Preview → designer confirmation → final validation.
8. Step 4.1: rename → merge → delete → create styles.
9. Step 4.2: apply styles to matching nodes.

Result: Complete, normalized style system created and bound to the layout.


## Example 3: Non-canonical size encountered

A text node uses 15px.

Actions:

1. Stop in planning mode.
2. Present:

   Detected non-canonical text size: 15px

   Possible mapping:
   - 14
   - 16
   - keep as custom

3. Wait for designer choice.
4. Continue only after confirmation.

Result: No silent snap. Designer owns the decision.


## Example 4: Legacy styles renamed instead of duplicated

File contains legacy styles: `H2`, `Button`, `Helper 1`.

Actions:

1. Map each to its normalized target:
   - `H2` → `Text/Heading/Semibold 32-AUTO`
   - `Button` → `Text/Action/Semibold 16-AUTO`
   - `Helper 1` → `Text/Body/Semibold 14-AUTO`
2. Present rename plan in preview.
3. On confirmation, rename existing styles (preserving all node bindings).
4. Only then identify remaining gaps and create new styles for those.

Result: No parallel duplicates. All existing bindings preserved.


# Troubleshooting

## FONT_CHECK_FAILED

Cause: One or more fonts used by text nodes are not available in Plugin API runtime.

Solution: Load the missing fonts in Figma and re-run the skill. Do not substitute fallback fonts. Typography phases stay blocked until all fonts resolve.


## Styles exist but are not applied to nodes

Cause: A style system is present in the file, but designers used raw values on specific nodes.

Solution: In audit mode, report as a layout/style mismatch finding. Propose rebinding during Step 4.2 after designer confirmation. Never rebind silently.


## Duplicate or near-duplicate styles detected

Cause: Legacy ad-hoc styles created without system (e.g., `Text 16`, `Paragraph 16`, `Body Copy`).

Solution: Cluster candidates into a single canonical role. Always rename the most-bound existing style first, then merge others into it. Never create a new canonical style while legacy equivalents still exist.


## Node flagged for background color style, but node is IMAGE / GRADIENT / VECTOR / GROUP

Cause: Apply logic must not overwrite image fills or structural nodes.

Solution: Skip automatically. Preserve image-bearing nodes unchanged. See `references/color-extraction.md` (apply safety rules) for the full skip list.


## Non-canonical text size rejected by designer

Cause: Designer wants to keep a size not divisible by 2px (e.g., 15px for a specific component).

Solution: Accept the exception. Classify under `Text/Exception/15` (or role-appropriate exception). Do not force normalization.


## Contrast validation reports violations

Cause: Proposed color assignments do not meet WCAG thresholds against target surfaces.

Solution: Present violations with nearest compliant alternatives (e.g., Neutral / 500 → Neutral / 600). Request designer confirmation before substitution. Never auto-correct.
