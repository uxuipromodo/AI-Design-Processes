# Color Extraction Strategy

Extract a structured color system from an existing layout.

Treat detected colors as signals, not final palette definitions.

Always normalize colors into system layers before style creation.


# Extraction Targets

Scan the layout and detect:

fills
text colors
stroke colors
background surfaces
overlay colors
accent colors
semantic colors


Group colors by usage role before naming.


# Color System Layers

Always classify colors into layers:

Neutral palette
Accent palette
Semantic palette


Normalize each layer independently.


# Neutral Palette Detection

Identify grayscale colors used for:

text
backgrounds
borders
surfaces
dividers
inactive states


Typical neutral candidates:

near-black
near-white
mid-gray values


Cluster grayscale values into tonal scale steps.


Example:

#111111
#2A2A2A
#444444

Map to:

Color / Grey / 700
Color / Grey / 600
Color / Grey / 500


Do not preserve raw grayscale values unless explicitly confirmed.


Always align with baseline neutral template.


# Neutral Template Merge Rules

Merge detected grayscale with baseline:

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


Never overwrite project palette.

Always merge and normalize.


If multiple detected values map to same step:

cluster together.


Ask confirmation before applying mapping.


# Pure Black and White Handling

Avoid assigning:

#000000
#FFFFFF

as primary anchors unless explicitly required.


Prefer mapped neutral equivalents instead.


Example:

#000000 → Color / Grey / 800
#FFFFFF → Color / Grey / White


Confirm before replacement.


# Accent Color Detection

Classify colors as Accent if used in:

buttons
links
active states
icons
highlights
interactive elements


Cluster accent colors into hue families.


Example:

#3B82F6
#2563EB
#1D4ED8

Cluster:

Accent / Blue


Avoid generating separate styles for small tonal variations.


Ask confirmation before clustering.


# Accent Palette Consolidation

If too many accent hues detected:

reduce palette to constrained families.


Prefer:

Primary accent

Optional secondary accent

Optional tertiary accent


Do not preserve isolated hues unless confirmed intentional.


# Semantic Color Detection

Detect semantic intent based on usage:

error states
success messages
alerts
status indicators
validation markers


Map into:

Success
Error
Warning
Info


If Success or Error missing:

propose generation.


If Warning or Info missing:

suggest optional creation.


Never auto-create semantic palette silently.


Always confirm first.


# Semantic Palette Normalization

Each semantic color should include:

background variant
foreground variant
border variant
icon variant


If missing:

propose completion set.


Example:

Success / Background
Success / Foreground
Success / Border
Success / Icon


Confirm before creation.


# Frequency-Based Color Priority

Colors used frequently:

prioritize as palette anchors.


Colors used once:

mark as exceptions.


Do not convert single-use colors into system palette automatically.


Ask confirmation before promotion.


# Contrast Validation Rules

Before applying palette:

validate:

primary text contrast

secondary text contrast

interactive states

component boundaries


Thresholds:

Body text ≥ 4.5:1

Large text ≥ 3:1

UI boundaries ≥ 3:1


If violations detected:

report before applying palette.


Offer adjustment suggestions.


# Surface Role Detection

Classify neutral surfaces into roles:

background
surface
elevated surface
overlay


Map accordingly.


Example:

Neutral / Background
Neutral / Surface
Neutral / Elevated


Confirm mapping before creation.


# Border Color Detection

Detect divider and outline colors.


Normalize into:

Neutral / Border / Subtle
Neutral / Border / Default
Neutral / Border / Strong


Cluster similar border colors together.


Ask confirmation before merge.


# Exception Handling

Detect colors that:

appear once

break palette harmony

do not match hue families


Mark them as:

Exceptions


Do not remove automatically.


Ask confirmation before removal.


# Naming Preparation Rules

Before creating styles:

ensure classification exists:

layer
role
step
variant


Then generate style name:


Color / Neutral / 500

Color / Accent / Primary

Color / Semantic / Success


Never create unnamed styles.
