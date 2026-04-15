# Scale Extension Strategy

Extend detected typography and color systems into complete, consistent scales.

Never extend silently.

Always propose extensions in planning mode before applying.


# Extension Philosophy

Treat extracted styles as incomplete signals.

Complete missing structural steps required for a usable system.

Prefer predictable scales over preserving accidental gaps.


# Typography Scale Extension

Canonical typography scale:

10
12
14
16
18
22
24
28
32


When detected sizes partially match scale:

snap detected values to nearest canonical steps.

Example:

23 → 24
27 → 28


If canonical steps missing:

propose adding them.


Example:

Detected:

14
16
18
32

Missing:

12
22
24
28


Ask confirmation before creation.


# Scale Gap Detection

Detect gaps larger than expected rhythm progression.

Example:

16 → 24

Suggest:

18
22


Never insert steps automatically.

Always confirm first.


# Frequency-Aware Extension

Prioritize steps near frequently used sizes.

Example:

Detected:

16 (frequent)
32 (rare)

Prefer extending around 16 first.


Avoid extending scale around rare sizes unless required.


# Role-Aware Typography Extension

Extend scale per role.

Example:

If Heading / 32 exists:

suggest:

Heading / 28
Heading / 24


If Body / 16 exists:

suggest:

Body / 14
Body / 18


Ask confirmation before creation.


# Line Height Completion

If extending typography scale:

generate matching line-height suggestions.


Example:

Heading / 28

line-height:

tight


Body / 18

line-height:

reading-friendly


Never leave extended styles without spacing definition.


# Weight Completion Rules

When extending roles:

apply default role weights.


Heading → semibold

Body → regular

Action → medium

Label → medium or regular


If unavailable:

use closest supported weight.


Confirm before substitution.


# Neutral Palette Extension

Baseline neutral palette:

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


If palette partially detected:

propose missing tonal steps.


Example:

Detected:

Gray 200
Gray 500
Gray 700


Missing:

Gray 50
Gray 100
Gray 300
Gray 400
Gray 600
Gray 800


Ask confirmation before generation.


# Neutral Tone Interpolation Rules

Generate missing neutral tones using tonal interpolation.

Preserve contrast hierarchy.


Do not overwrite detected tones.


Merge instead of replacing.


# Accent Palette Extension

If accent color detected:

propose tonal ladder.


Example:

Accent / Blue detected


Suggest:

Accent / Blue / Light
Accent / Blue / Default
Accent / Blue / Strong


Ask confirmation before creation.


Do not create full ladders automatically.


# Semantic Variant Completion

Each semantic color should include:

Background
Foreground
Border
Icon


Example:

Success / Background
Success / Foreground
Success / Border
Success / Icon


If missing:

propose completion set.


Confirm before applying.


# Surface Layer Completion

If surface hierarchy incomplete:

suggest:

Background
Surface
Elevated
Overlay


Ask confirmation before extension.


# Exception Preservation Policy

Do not delete one-off styles automatically.

Mark them as:

Exceptions


Ask whether to:

preserve
merge
remove


Never decide automatically.


# Naming Alignment During Extension

All generated styles must follow naming convention:


Text / Role / Size


Color / Neutral / Step

Color / Accent / Name

Color / Semantic / Variant


Reject unnamed generated steps.


# Planning Mode Output Requirements

Before applying extensions:

show detected scale

show missing steps

show suggested additions

show interpolation logic

show naming results

show semantic variant completion

show exception candidates


Wait for confirmation before creation.