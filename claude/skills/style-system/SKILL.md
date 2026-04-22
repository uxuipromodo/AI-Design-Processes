---
name: style-system-builder
description: Extract, normalize, extend, and apply typography and color styles from a Figma layout using planning mode.
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


# Operating Mode

Always run in planning mode.

PHASE 0 — FONT AVAILABILITY CHECK

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

Pipeline:

1. Run font availability check on all text nodes
2. Read all local text styles
3. Read all local color styles
4. Extract typography scale
5. Extract grayscale palette
6. Detect semantic colors
7. Detect duplicates
8. Detect near-duplicates
9. Detect missing scale steps
10. Propose normalized system
11. Show preview
12. Ask confirmation
13. Apply changes only after approval


FINAL PHASE — CREATE / APPLY STYLES TO FILE

After planning-mode confirmation, the skill may:

1. Create normalized text styles
2. Create normalized color styles
3. Apply created styles back to matching nodes in the file


Supported output modes:

- Analyze only
- Create styles only
- Create and apply styles


Rules:

- default mode remains planning mode first
- no styles are created before confirmation
- no styles are applied before confirmation
- in Create styles only mode, create styles but do not bind them to nodes
- in Create and apply styles mode, create styles and apply them to matching text and color nodes in the file
- the final step may include optional rebinding or application to the file, not only style generation


# Audit Mode

The style-system skill supports a structured audit-mode workflow.

Audit behavior is defined in:

references/audit-principles.md

Audit mode:

- detects style inconsistencies
- reports structured issues
- assigns severity levels
- suggests normalization options
- requires designer confirmation
- performs a final validation pass
- only then allows style creation or application

Audit mode never modifies styles or layout before confirmation.


# Typography System Rules

Base rhythm:

2px


Typography uses a 2px step grid.

Any font size divisible by 2px is canonical.

Any font size not divisible by 2px is non-canonical.

Canonical examples:

4
6
8
10
12
14
16
18
20
24
32
40
48
64


Role mapping:

Heading → semibold  
Body → regular  
Action → medium  
Label → medium or regular


Cluster detected styles into semantic roles before naming:

Heading
Body
Action
Label


Do not generate purely numeric text styles unless classification is ambiguous.


# Non-Canonical Text Size Rule

If a detected text size is not divisible by 2px:

do not normalize automatically

do not snap silently

do not assign a final style automatically

Stop in planning mode and show:

Detected non-canonical text size: {size}px

Possible mapping:
- {nearest lower canonical step}
- {nearest higher canonical step}
- keep as custom

Choose target role and size before continuing.


If scale steps are missing:

propose contextual extension only when role structure requires it


Example:

Detected:

14
16
18
32

Proposed:

12
20
30

Ask confirmation before creation.


# Line Height and Tracking Rules

Infer spacing from role:

Heading:

- tighter line height
- optional tighter tracking for large sizes

Body:

- neutral line height
- neutral tracking

Label / Action:

- compact line height
- optional wider tracking for dense UI labels


Never leave inferred values undefined when extending scale.


# Color System Layers

Build color styles in layers:

1. Neutral palette
2. Brand / accent palette
3. Semantic palette


Always normalize Neutral palette first.


Color audit must be node-driven and style-aware.

Build the audit color universe from:

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


Automatic color application is restricted to semantically valid solid-fill targets only.

Apply color styles only to nodes that already contain an intentional SOLID fill.

Do not apply background color styles to IMAGE, GRADIENT, VIDEO, or any other non-solid paints.

Do not apply background color styles to mixed or multi-fill nodes unless explicitly confirmed.

Do not add new background fills to structural nodes automatically.

Skip by default:

- structural auto-layout wrappers
- section wrapper frames
- footer column wrappers
- structural container frames
- logo containers
- icon containers
- vector-only containers


Never apply background color styles automatically to:

- VECTOR nodes
- BOOLEAN_OPERATION nodes
- GROUP nodes
- frames whose children are only vectors or icons
- nodes whose names indicate logo or icon when such naming exists


Preserve image-bearing nodes unchanged.

Auto-layout frames must not receive background color styles unless they already had an intentional solid fill before normalization.


# Neutral Palette Template

Merge detected grayscale with baseline template:

White

Gray 15
Gray 25
Gray 50
Gray 100
Gray 200
Gray 300
Gray 400
Gray 500
Gray 600
Gray 700
Gray 800


Never replace project grayscale.

Always merge and normalize.


Example behavior:

Detected:

#111111
#2A2A2A
#444444

Propose mapping into:

Color / Neutral / Gray 700
Color / Neutral / Gray 600
Color / Neutral / Gray 500


Ask confirmation before applying.


Avoid defaulting to pure black or pure white unless explicitly required by the layout.


# Semantic Colors

Ensure presence of baseline semantic colors:

Success
Error


If missing:

propose creation


Also check:

Warning
Info


Do not create optional semantic colors silently.


Always confirm before creation.


# Accent Color Clustering

If multiple accent hues detected:

cluster into constrained palette families


Prefer intentional accent groups over preserving one-off colors.


Ask confirmation before palette consolidation.


# Accessibility Validation

Before applying proposed color system:

validate contrast for:

primary body text
secondary body text
large headings
UI component boundaries


Contrast thresholds:

Body text ≥ 4.5:1  
Large text ≥ 3:1  
UI boundaries ≥ 3:1


If violations detected:

report before applying styles


Offer adjustment suggestions.


# Naming Convention

Text styles:

Text / Heading / {weight} {size}/{line-height}
Text / Body / {weight} {size}/{line-height}
Text / Action / {weight} {size}/{line-height}
Text / Label / {weight} {size}/{line-height}

The `{weight}` is the exact font style string (e.g. `Regular`, `Medium`, `Bold`, `Light`).
The `{size}` is the font size in px. The `{line-height}` is the line height as a percentage integer derived from the style, or `AUTO`.

Correct examples:
- `Text / Heading / Medium 24/120`
- `Text / Body / Regular 16/150`
- `Text / Action / Medium 13/200`
- `Text / Caption / Regular 12/AUTO`

WRONG — never use semantic size suffixes as the final segment:
- `Text / Body / SM` ❌
- `Text / Body / Base` ❌
- `Text / Heading / LG` ❌
- `Text / Action / MD` ❌

Semantic suffixes (SM, Base, MD, LG, XS) are subjective and ambiguous.
The `{weight} {size}/{line-height}` format is the only allowed form.
If you see a reason to deviate, ask the user before creating any styles.

See references/naming-convention.md for full naming rules.


Color styles:

Color / Neutral / White

Color / Neutral / Gray {step}

Color / Semantic / Success
Color / Semantic / Error
Color / Semantic / Warning
Color / Semantic / Info


Do not generate unnamed styles.


Always normalize naming before creation.


# Style Deduplication Rules

If styles differ only slightly:

cluster together


Example:

31px
32px
30px

Normalize:

Text / Heading / 32


Ask confirmation before merge.


# System-First Normalization Policy

Treat detected styles as candidate system inputs, not final truth.


Prefer normalization over duplication.


Do not preserve random one-off values unless confirmed intentional.


Constrain palette hue count when possible.


Prefer role-based hierarchy over size-only hierarchy.


# Preview Output Requirements

Before applying:

show detected typography scale

show detected grayscale palette

show detected semantic palette

show missing steps

show clustering decisions

show proposed naming

show accessibility warnings

show palette merges


Then request confirmation.


Apply changes only after approval.
