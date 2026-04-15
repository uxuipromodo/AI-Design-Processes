# Typography Extraction Strategy

Extract a structured typography system from an existing layout.

Treat detected text styles as signals of intent, not final system definitions.

Always normalize extracted typography into semantic roles and canonical scale.


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

Heading / 32
Heading / 28
Heading / 24


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

Action / 14
Action / 16


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

Label / 10
Label / 12


# Size Clustering Rules

Cluster nearby font sizes together.

Example:

31
32
30

Normalize:

32


Example:

15
16

Normalize:

16


Ask confirmation before merging clusters.


# Canonical Scale Alignment

Project typography scale:

10
12
14
16
18
22
24
28
32


When detected sizes fall between steps:

snap to nearest canonical size


Example:

23 → 24
27 → 28


Confirm before applying normalization.


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

Text / Heading / 32
Text / Body / 16
Text / Action / 14
Text / Label / 10