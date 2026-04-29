# Scale Extension Strategy

Extend detected typography and color systems into complete, consistent scales.

Never extend silently.

Always propose extensions in planning mode before applying.


# Extension Philosophy

Treat extracted styles as incomplete signals.

Complete missing structural steps required for a usable system.

Prefer predictable scales over preserving accidental gaps.


# Typography Scale Extension

Typography extension uses a 2px step grid.

Any size divisible by 2px is canonical.

Any size not divisible by 2px is non-canonical and must stop in planning mode before extension continues.


Do not suggest missing values from a universal fixed list.

If detected typography already fits a coherent 2px rhythm:

do not suggest unnecessary additions.


When extension is needed:

suggest only adjacent useful sizes based on semantic role range and real gaps.

Example:

If Heading / 32 exists:

30 or 34 may be valid only if neighboring heading steps are needed.


If Body / 16 exists:

14 or 18 may be valid only if surrounding body roles require them.


Example:

Detected:

14
16
18
32

Suggest only if context requires:

20 for subheading continuity
30 for heading continuity


Ask confirmation before creation.


# Scale Gap Detection

Detect gaps larger than expected rhythm progression.

Example:

16 → 24

Suggest:

18
20


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

Heading / 30
Heading / 34


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

Full naming rules, legacy-rename order, and stability policies are defined in:

references/naming-convention.md

Do not introduce alternative naming during extension.


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
