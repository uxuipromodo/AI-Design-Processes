# Naming Convention Strategy

Naming work happens inside the audit workflow defined in:

references/audit-principles.md

Legacy style renaming (see "Legacy Style Renaming Rules" below) must always
run before any new style creation, as part of Step 4.1 of the audit workflow.

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

Text/Heading/Semibold 32-110
Text/Body/Regular 16-150
Color/Neutral/Gray 500

Incorrect:

Heading Large
Body Default
Gray Dark
Blue 2


# Typography Naming Structure

Format:

Role/Weight Size

CRITICAL — Figma folder rules:
- Each `/` in a style name creates a new folder level in Figma's style panel.
- Do NOT use spaces around `/` — they become part of the folder name and create visual clutter.
- Do NOT use a global `Text/` prefix — Figma already separates text styles from color styles in the panel. Adding `Text/` creates a redundant top-level folder.
- One `/` separator → one folder level: Role → style name
- Example: `Heading/Bold 32` → folder `Heading` → style `Bold 32` ✅
- WRONG: `Text/Heading/Bold 32` → extra top-level `Text` folder ❌

Do NOT include line-height in the style name.
Line-height is a property of the style definition, not a label. It clutters the panel and becomes outdated when values change.

WRONG:
- `Heading/Bold 32-106` ❌  (line-height suffix)
- `Body/Regular 16-150` ❌  (line-height suffix)
- `Label/Medium 12-AUTO` ❌  (AUTO suffix)

CORRECT:
- `Heading/Bold 32` ✅
- `Body/Regular 16` ✅
- `Label/Medium 12` ✅


Roles:

Heading
Body
Action
Label


Examples:

Heading/Bold 32
Heading/SemiBold 32
Heading/Medium 32
Heading/Bold 26
Heading/Bold 18
Heading/ExtraBold 18

Body/Bold 16
Body/SemiBold 16
Body/Bold 14
Body/SemiBold 14
Body/Medium 14
Body/Regular 14

Action/SemiBold 16
Action/Medium 16

Label/SemiBold 12
Label/Regular 12
Label/Bold 12


Never skip role classification.

Never use semantic size suffixes (SM, Base, MD, LG, XS) as the final segment.

WRONG:
- Body/SM ❌
- Body/Base ❌
- Heading/LG ❌
- Action/MD ❌

These suffixes are subjective, ambiguous, and break the naming contract.
The `Weight Size` format is the only allowed form.
If you see a reason to deviate, ask the user before creating any styles.


# Multi-Font Naming Rules

If multiple font families detected:

separate style namespaces per family


Example:

UI/Heading/Bold 32
Editorial/Heading/Bold 32


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

Do NOT include line-height in the style name.

Line-height is a property stored inside the style definition. It does not belong in the name — it clutters the panel and becomes a maintenance burden when values change.

WRONG:
- `Heading/Bold 32-137` ❌
- `Body/Regular 14-141` ❌
- `Action/Medium 16-AUTO` ❌

CORRECT:
- `Heading/Bold 32` ✅
- `Body/Regular 14` ✅
- `Action/Medium 16` ✅

Set the correct line-height value in the style definition. Never encode it in the name.


# Letter Spacing Naming Policy

Do not include tracking unless:

uppercase labels
UI-specific variants


Example:

Text/Label/12 Caps


Ask confirmation before suffix creation.


# Neutral Palette Naming Structure

Format:

Neutral/Gray Step

Do NOT use a global `Color/` prefix — Figma already separates color styles from text styles in the panel. Adding `Color/` creates a redundant top-level folder.

WRONG: `Color/Neutral/Gray 500` ❌  (extra top-level `Color` folder)
CORRECT: `Neutral/Gray 500` ✅

Examples:

Neutral/White
Neutral/Gray 50
Neutral/Gray 100
Neutral/Gray 500
Neutral/Gray 800


Do not use:

Light
Dark
Soft
Strong


Always prefer numeric scale steps.


# Accent Palette Naming Structure

Format:

Accent/Name

Do NOT use a global `Color/` prefix.

WRONG: `Color/Accent/Primary` ❌
CORRECT: `Accent/Primary` ✅

Examples:

Accent/Primary
Accent/Secondary
Accent/Blue


Avoid:

Blue/1
Brand Blue Dark


Cluster tonal variations under same accent family.


Example:

Accent/Blue
Accent/Blue Dark
Accent/Blue Light


Confirm before splitting tonal variants.


# Semantic Palette Naming Structure

Format:

Semantic/Role

Do NOT use a global `Color/` prefix.

WRONG: `Color/Semantic/Error` ❌
CORRECT: `Semantic/Error` ✅

Roles:

Success
Error
Warning
Info


Variant naming:

Semantic/Success/Background
Semantic/Success/Foreground
Semantic/Success/Border
Semantic/Success/Icon


Never create semantic colors without role suffix.


# Surface Naming Structure

Format:

Surface/Role

Do NOT use a global `Color/` prefix.

WRONG: `Color/Surface/Background` ❌
CORRECT: `Surface/Background` ✅

Roles:

Background
Surface
Elevated
Overlay


Example:

Surface/Background
Surface/Elevated


Confirm before generating surface hierarchy.


# Border Naming Structure

Format:

Border/Role

Do NOT use a global `Color/` prefix.

WRONG: `Color/Border/Subtle` ❌
CORRECT: `Border/Subtle` ✅

Roles:

Subtle
Default
Strong


Example:

Border/Subtle
Border/Default
Border/Strong


Cluster similar border colors before naming.


# Legacy Style Renaming Rules

Detect legacy names such as:

Heading Large
Body Text
Gray Dark
Primary Blue
H1, H2, H3, H4, H5
Button
Helper 1, Helper 2
Body text


Renaming existing styles is ALWAYS the first action — before creating any new style.

MANDATORY order:
1. Build a complete map of existing styles → their normalized target names
2. Present the rename plan in the preview
3. Get confirmation
4. Rename — this preserves all existing node bindings automatically
5. Only then identify true gaps (roles with no existing style to rename)
6. Create new styles only for those gaps

Never create a new style if an existing style can be renamed to fill that role.
Creating a parallel style alongside a legacy one produces duplicates and splits bindings.

Example:

Existing: H2 (32px SemiBold) → rename to Text/Heading/SemiBold 32-AUTO
Existing: Button (16px SemiBold) → rename to Text/Action/SemiBold 16-AUTO
Existing: Helper 1 (14px SemiBold) → rename to Text/Body/SemiBold 14-AUTO

Do NOT create Text/Heading/SemiBold 32-AUTO as a new style while H2 still exists.

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

Text/Body/16


Ask confirmation before merge.


# Exception Naming Rules

If style cannot be classified:

mark as:

Exception


Example:

Text/Exception/15


Do not delete automatically.


Ask confirmation before removal or merge.


# Naming Stability Rules

Once style name exists:

do not regenerate alternative naming variants.


Example:

If exists:

Text/Body/16


Do not create:

Text/Paragraph/16


Prefer existing naming anchor.


# Planning Mode Naming Preview

Before applying naming changes:

show:

renamed styles
merged styles
exception styles
new styles


Wait for confirmation before applying updates.
