# Accessibility Validation Strategy

Accessibility validation runs against the color layer structure defined in:

references/color-extraction.md

Neutral / Accent / Semantic / Surface / Border layer roles referenced below
are normalized during color extraction.

Validate readability, contrast, and visual clarity of the generated typography and color system before applying styles.

Never apply a proposed style system without accessibility checks.


# Validation Scope

Run validation on:

text colors
background colors
surface layers
semantic colors
interactive states
component boundaries


Report issues in planning mode before applying changes.


# Contrast Requirements

Minimum thresholds:

Body text ≥ 4.5:1

Large text ≥ 3:1

UI component boundaries ≥ 3:1

Interactive elements ≥ 3:1


If violations detected:

report location
report failing values
suggest nearest compliant alternative


Never silently adjust contrast values.


Always request confirmation.


# Body Text Validation

Validate:

Text / Body / 16
Text / Body / 14
Text / Body / 18


Ensure readable contrast against:

Background
Surface
Elevated surface


If insufficient contrast:

suggest nearest neutral adjustment.


Example:

Neutral / 500 → Neutral / 600


Confirm before replacement.


# Heading Validation

Validate:

Text / Heading / 32
Text / Heading / 28
Text / Heading / 24


Ensure minimum:

3:1 contrast


Prefer stronger contrast when used over imagery or overlays.


Suggest fallback colors if contrast fails.


# Label and Metadata Validation

Validate:

Text / Label / 10
Text / Label / 12


Labels often appear in compact UI zones.


Ensure contrast ≥ 4.5:1 whenever label communicates critical information.


If decorative only:

allow relaxed threshold.


Ask confirmation before relaxing contrast enforcement.


# Surface Hierarchy Validation

Ensure clear separation between:

Background
Surface
Elevated
Overlay


Detect insufficient elevation contrast.


Example:

Surface ≈ Background


Suggest stronger neutral step separation.


Example:

Neutral / 50 → Neutral / 100


Confirm before applying change.


# Border Visibility Validation

Detect divider and outline contrast.


Minimum:

3:1 against adjacent surfaces


Cluster border colors into:

Subtle
Default
Strong


Suggest nearest compliant alternative if contrast insufficient.


# Semantic Color Validation

Validate:

Success
Error
Warning
Info


Ensure semantic colors remain distinguishable from neutral palette.


Detect ambiguity cases:

Success ≈ Accent green

Error ≈ Accent red


Suggest semantic isolation if overlap detected.


Confirm before adjustment.


# Semantic Variant Validation

Each semantic role should support:

Background
Foreground
Border
Icon


Validate:

foreground readability over semantic background


Example:

Success / Foreground over Success / Background


Ensure ≥ 4.5:1 contrast


Suggest correction if insufficient.


# Interactive State Validation

Validate:

links
buttons
focus states
hover states
active states


Ensure visible distinction from surrounding UI.


Detect:

accent colors too close to surface tones


Suggest stronger accent step if needed.


Confirm before adjustment.


# Disabled State Validation

Detect disabled text and controls.


Ensure:

visually distinct from active elements

still readable when required


Avoid:

too-low contrast values that break usability


Suggest neutral adjustments where needed.


# Overlay and Image Background Validation

Detect text placed on:

images
gradients
blurred surfaces
overlays


Ensure readable fallback contrast exists.


Example:

add overlay layer
increase text contrast
switch to stronger neutral


Ask confirmation before applying fallback strategy.


# Accent Color Contrast Validation

Ensure accent colors used for:

links
primary buttons
active indicators


maintain contrast ≥ 3:1 against surrounding surfaces


Suggest tonal adjustment if needed.


# Exception Reporting

If validation fails:

list affected styles

list failing contrast ratios

suggest nearest compliant alternatives


Never auto-correct silently.


Always confirm adjustments.


# Planning Mode Output Requirements

Before applying styles:

show contrast failures

show semantic conflicts

show surface hierarchy issues

show border visibility issues

show overlay readability issues

show suggested corrections


Wait for confirmation before applying fixes.
