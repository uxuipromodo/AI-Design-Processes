# Naming Convention Strategy

Ensure all generated styles follow a predictable, role-based naming system.

Naming must be stable across projects, scalable over time, and readable by humans.


# Naming Philosophy

Style names must describe:

role
scale position
semantic intent

Avoid:

raw numeric-only names
font-family-based names
visual guesses without classification


Example:

Correct:

Text / Heading / 32 / Semibold
Text / Body / 16 / Regular
Color / Grey / 500

Incorrect:

Heading Large
Body Default
Gray Dark
Blue 2


# Typography Naming Structure

Format:

Text / Role / Size / Weight


Roles:

Heading
Body
Action
Label


Examples:

Text / Heading / 32 / Semibold
Text / Heading / 24 / Semibold

Text / Body / 16 / Regular
Text / Body / 14 / Regular

Text / Action / 16 / Medium

Text / Label / 12 / Medium
Text / Label / 10 / Medium


Never skip role classification.


# Multi-Font Naming Rules

If multiple font families detected:

separate style namespaces per family


Example:

Text / UI / Heading / 32 / Semibold
Text / Editorial / Heading / 32 / Semibold


Do not merge typography systems across font families automatically.


Ask confirmation before consolidation.


# Weight Handling Policy

Weight must appear in typography style names.

Use real weight labels when available:

Regular
Medium
Semibold
Bold


Do not use numeric weight values in style names unless unavoidable.


# Line Height Naming Policy

Do not include line-height in style name unless multiple variants exist.


Example allowed:

Text / Body / 16 / Dense
Text / Body / 16 / Relaxed


Otherwise:

omit line-height suffix.


# Letter Spacing Naming Policy

Do not include tracking unless:

uppercase labels
UI-specific variants


Example:

Text / Label / 12 / Caps


Ask confirmation before suffix creation.


# Neutral Palette Naming Structure

Format:

Color / Grey / Step


Examples:

Color / Grey / White
Color / Grey / 50
Color / Grey / 100
Color / Grey / 500
Color / Grey / 800


Do not use:

Light
Dark
Soft
Strong


Always prefer numeric scale steps.


# Accent Palette Naming Structure

Format:

Color / Accent / Name


Examples:

Color / Accent / Primary
Color / Accent / Secondary
Color / Accent / Blue


Avoid:

Color / Blue / 1
Color / Brand Blue Dark


Cluster tonal variations under same accent family.


Example:

Color / Accent / Blue


Confirm before splitting tonal variants.


# Semantic Palette Naming Structure

Format:

Color / Semantic / Role


Roles:

Success
Error
Warning
Info


Variant naming:

Color / Semantic / Success / Background
Color / Semantic / Success / Foreground
Color / Semantic / Success / Border
Color / Semantic / Success / Icon


Never create semantic colors without role suffix.


# Surface Naming Structure

Format:

Color / Surface / Role


Roles:

Background
Surface
Elevated
Overlay


Example:

Color / Surface / Background
Color / Surface / Elevated


Confirm before generating surface hierarchy.


# Border Naming Structure

Format:

Color / Border / Role


Roles:

Subtle
Default
Strong


Example:

Color / Border / Subtle


Cluster similar border colors before naming.


# Legacy Style Renaming Rules

Detect legacy names such as:

Heading Large
Body Text
Gray Dark
Primary Blue


Propose normalized replacements.


Example:

Heading Large → Text / Heading / 32
Gray Dark → Color / Neutral / 700


Never rename automatically.

Always confirm first.


# Duplicate Detection Rules

If multiple styles map to same semantic role:

merge candidates


Example:

Text 16
Paragraph 16
Body Copy


Normalize:

Text / Body / 16


Ask confirmation before merge.


# Exception Naming Rules

If style cannot be classified:

mark as:

Exception


Example:

Text / Exception / 15


Do not delete automatically.


Ask confirmation before removal or merge.


# Naming Stability Rules

Once style name exists:

do not regenerate alternative naming variants.


Example:

If exists:

Text / Body / 16


Do not create:

Text / Paragraph / 16


Prefer existing naming anchor.


# Planning Mode Naming Preview

Before applying naming changes:

show:

renamed styles
merged styles
exception styles
new styles


Wait for confirmation before applying updates.
