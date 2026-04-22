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

Text / Heading / Semibold 32/110
Text / Body / Regular 16/150
Color / Neutral / Gray 500

Incorrect:

Heading Large
Body Default
Gray Dark
Blue 2


# Typography Naming Structure

Format:

Text / Role / Weight Size/LineHeight


Roles:

Heading
Body
Action
Label


Examples:

Text / Heading / Semibold 32/110
Text / Heading / Semibold 24/120

Text / Body / Regular 16/150
Text / Body / Regular 14/150

Text / Action / Medium 16/120

Text / Label / Medium 12/100
Text / Label / Medium 10/100


Never skip role classification.

Never use semantic size suffixes (SM, Base, MD, LG, XS) as the final segment.

WRONG:
- Text / Body / SM ❌
- Text / Body / Base ❌
- Text / Heading / LG ❌
- Text / Action / MD ❌

These suffixes are subjective, ambiguous, and break the naming contract.
The `Weight Size/LineHeight` format is the only allowed form.
If you see a reason to deviate, ask the user before creating any styles.


Keep size and line-height in the final visible segment.

Do not create extra slash nesting for size.

Use integer values in the visible name.

Represent line-height as percentage-style shorthand derived from the style definition.


Example:

14 with 150% line-height → 14/150
32 with 110% line-height → 32/110


# Multi-Font Naming Rules

If multiple font families detected:

separate style namespaces per family


Example:

Text / UI / Heading / Semibold 32/110
Text / Editorial / Heading / Semibold 32/110


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

Line-height must appear in the final visible typography style name.

Keep line-height in the last segment together with size.


Examples:

Text / Body / Regular 16/150
Text / Heading / Semibold 32/110


# Letter Spacing Naming Policy

Do not include tracking unless:

uppercase labels
UI-specific variants


Example:

Text / Label / 12 / Caps


Ask confirmation before suffix creation.


# Neutral Palette Naming Structure

Format:

Color / Neutral / Gray Step


Examples:

Color / Neutral / White
Color / Neutral / Gray 50
Color / Neutral / Gray 100
Color / Neutral / Gray 500
Color / Neutral / Gray 800


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
