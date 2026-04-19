# Typography Extraction Strategy

Extract a structured typography system from an existing layout.

Treat detected text styles as signals of intent, not final system definitions.

Always normalize extracted typography into semantic roles and canonical scale.


# Font Availability Guard

Typography extraction must not begin before font availability is verified.

Before any classification or normalization:

- scan text nodes in the current file
- detect all used font families
- detect all used styles or weights for each family
- verify each detected font family and style is available in Plugin API runtime

If any font is unavailable:

stop immediately

return:

FONT_CHECK_FAILED

list missing fonts in this format:

Missing fonts:
– {Font Family} / {Style}
– {Font Family} / {Style}

Do not use fallback fonts.

Do not continue classification.

Do not propose typography styles.

Do not create text styles after a failed font check.


# Extraction Targets

Scan the layout and detect:

font size
font weight
line height
letter spacing
font family
text casing
usage frequency
visual hierarchy position


Cluster styles by role before assigning names.


# Role Detection Rules

Map detected typography into roles:

Heading
Body
Action
Label


Do not assign numeric-only styles unless role detection fails.


Semantic role ranges guide classification but do not override layout context:

8–12 → Caption / Label / Microcopy
14–18 → Body / UI text
20–24 → Subheading / Intermediate heading
28–40 → Heading
48+ → Display


# Heading Detection

Classify as Heading if:

large font size relative to surrounding content

OR

semibold or bold weight combined with prominence

OR

used as section title

OR

visually separated by spacing above/below


Prefer semantic grouping:

Text / Heading / 32 / Semibold
Text / Heading / 28 / Semibold
Text / Heading / 24 / Semibold


Avoid creating excessive heading levels unless layout clearly requires them.


# Body Detection

Classify as Body if:

used in paragraphs

OR

default reading text

OR

appears repeatedly across screens

OR

line height optimized for readability


Prefer:

Body / 16

Allow:

Body / 14
Body / 18


Avoid multiple competing body sizes unless justified.


# Action Detection

Classify as Action if used inside:

buttons
interactive labels
navigation items
menu entries
tabs


Typical characteristics:

medium weight

compact spacing

short text length


Example:

Text / Action / 14 / Medium
Text / Action / 16 / Medium


# Label Detection

Classify as Label if used as:

metadata
helper text
field labels
small UI indicators
status markers


Typical size:

10
12


Often uppercase or semi-condensed.


Example:

Text / Label / 10 / Medium
Text / Label / 12 / Medium


# Size Clustering Rules

Cluster nearby font sizes together.

Example:

31
32
30

If all sizes are divisible by 2px:

treat them as canonical candidates


Example:

15
16

Do not normalize automatically.

Show in planning mode:

Detected non-canonical text size: 15px

Possible mapping:
- 14
- 16
- keep as custom


Ask confirmation before merging clusters.


# Canonical Scale Alignment

Typography uses a 2px step grid.

Any detected size divisible by 2px is canonical.

Any detected size not divisible by 2px is non-canonical.


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


When detected sizes are not divisible by 2px:

do not snap silently

do not assign a final style automatically


Show in planning mode:

Detected non-canonical text size: {size}px

Possible mapping:
- {nearest lower canonical step}
- {nearest higher canonical step}
- keep as custom


Choose target role and size before continuing.


# Frequency-Based Priority

Styles used frequently:

prioritize as canonical system candidates


Styles used once:

mark as possible exceptions


Do not automatically convert one-off styles into system styles.


Ask confirmation before removal or merge.


# Line Height Extraction Rules

If explicit line height exists:

preserve relationship


If Auto line height detected:

infer based on role


Heading:

tight spacing


Body:

comfortable reading spacing


Label:

compact spacing


Never leave inferred line height undefined when generating new styles.


# Letter Spacing Extraction Rules

Infer tracking from role:

Heading:

slightly tighter for large sizes


Body:

neutral


Label:

slightly wider when uppercase


Preserve explicit tracking if present.


# Weight Normalization Rules

Map weights into role defaults:

Heading → semibold

Body → regular

Action → medium

Label → medium or regular


If project font lacks these weights:

choose nearest available alternative


Ask confirmation before remapping weights.


# Font Family Handling

If multiple font families detected:

group styles per family


Example:

Primary font → UI system styles

Secondary font → editorial styles


Do not merge families automatically.


Ask confirmation before consolidation.


# Exception Handling

Detect styles that:

appear once

break scale logic

break role mapping


Mark them as:

Exceptions


Do not delete automatically.


Ask confirmation before removal.


# Naming Preparation Rules

Before style creation:

ensure mapping exists:

role
size
weight
line height


Then generate style name:

Text / Role / Size


Example:

Text / Heading / 32 / Semibold
Text / Body / 16 / Regular
Text / Action / 14 / Medium
Text / Label / 10 / Medium
