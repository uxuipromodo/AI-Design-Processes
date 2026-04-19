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

Color / Grey / 700
Color / Grey / 600
Color / Grey / 500


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

Text / Heading / {size} / {weight}
Text / Body / {size} / {weight}
Text / Action / {size} / {weight}
Text / Label / {size} / {weight}


Color styles:

Color / Grey / White

Color / Grey / {step}

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
