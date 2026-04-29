# Audit Principles

Define a planning-first audit mode for style-system work in Figma files.

Audit inspects existing styles, layout usage, and mismatches between them.

Audit itself never modifies the file.


# Audit Purpose

Use audit mode to:

inspect existing styles
inspect actual values used in layouts
compare styles against layout usage
detect style-system issues
detect layout usage issues
present issues clearly
suggest possible resolutions
wait for designer confirmation
perform final validation
allow execution only after confirmation


# Workflow Model

PHASE 1 — AUDIT

Inspect styles and layout usage within the requested scope.

Detect issues, classify severity, and prepare suggested resolutions.

IMPORTANT: All data collection MUST be performed via `use_figma` (Plugin API).
Do NOT use `get_metadata` or `get_design_context` as primary audit tools — they provide
only structural overviews and lack full node-level property access.
`get_metadata`/`get_design_context` may only be used for quick file orientation if needed.


PHASE 2 — DESIGNER CONFIRMATION

Present findings and wait for the designer to confirm which actions should proceed.

Nothing is executed automatically during the audit phase.

IMPORTANT: Accessibility validation is MANDATORY before presenting PHASE 2.
Before showing findings to the designer, run a `use_figma` call to:
1. Collect text fill color + nearest opaque background color for each TEXT node
2. Calculate contrast ratio for each text/background pair
3. Flag all pairs failing WCAG thresholds (Body ≥ 4.5:1, Large text ≥ 3:1, UI ≥ 3:1)
Include the accessibility report in the PHASE 2 output.
Do NOT present PHASE 2 without the accessibility section.


PHASE 3 — FINAL CONFIRMATION / VALIDATION

Run one more validation pass after designer confirmation and before execution.

Verify that confirmed actions remain valid and conflict-free.


PHASE 4 — APPLY CHANGES

Changes are allowed only after designer confirmation and final validation.


Execution occurs only after designer confirmation and final validation.

Execution always happens in two ordered steps.

Step 2 MUST NOT begin until Step 1 is fully complete and validated.
Never create new styles before renaming or merging existing ones.
Never apply styles to nodes before the style system is finalized.

Step 1 — Update style system
This step may include:
- renaming existing styles to normalized names (ALWAYS first)
- merging duplicate styles (ALWAYS before creating new ones)
- deleting unused styles
- creating missing styles (ONLY after rename and merge are done)
- normalizing naming

CRITICAL ORDER within Step 1:
1. rename existing → normalized name
2. merge duplicates → single canonical style
3. delete unused
4. create new styles only for gaps that remain after rename/merge

Never create a new style if an existing style can be renamed to fill that role.
If an existing style already covers a role, rename it — do not create a parallel style.

Step 2 — Apply styles to layout nodes
This step may include:
- rebinding nodes to styles
- replacing raw values with styles
- replacing deprecated styles on nodes
- applying normalized typography
- applying normalized colors


STEP 4.1 — UPDATE STYLE SYSTEM

May include:

create missing styles
rename styles
merge duplicate styles
delete unused styles
normalize naming


STEP 4.2 — APPLY TO LAYOUT

May include:

apply styles to nodes
replace raw values with styles
replace deprecated styles on nodes
rebind nodes to normalized styles


# Audit Scopes

Audit scope is determined by the user prompt.

Audit may target:
- the entire file
- a page
- a frame
- a selection


Supported audit scopes:

Typography audit
Color audit
Style library audit
Full style audit


Binding and application issues are included as audit findings and final apply decisions.


# Issue Taxonomy

Classify findings into the following issue groups.


## Typography Issues

Examples:

raw typography values without styles
styles exist but are not applied
non-canonical sizes
duplicate text styles
near-duplicate text styles
inconsistent naming
unused text styles
inconsistent role hierarchy


## Color Issues

Examples:

raw colors without styles
styles exist but are not applied
colors outside palette
duplicate color styles
near-duplicate colors
inconsistent neutral palette
unused color styles
semantic color inconsistencies


## Style Library Issues

Examples:

duplicate styles
fragmented naming
inconsistent naming patterns
deprecated styles
redundant styles
unused styles


## Layout / Style Mismatch Issues

Examples:

node visually matches a style but style is not applied
wrong style applied to node
raw value used where style exists
deprecated style still used in layout


# Severity Model

Use severity to prioritize audit output.


Critical

system-breaking, inconsistent, or high-risk issues


Warning

clear problems that should likely be fixed


Suggestion

non-blocking cleanup or optimization opportunities


# Audit Output Format

Present each finding using this structure:

Issue type
Severity
Detected values
Why it is suspicious
Suggested resolution
Requires confirmation


Each detected issue should be reported using the following structure:

Issue type
Severity
Detected values
Why this is suspicious
Suggested resolution
Requires confirmation


Keep wording concise, production-oriented, and clear.


# Designer Confirmation Model

After audit, the designer chooses which suggested actions to confirm.


Examples of confirmable actions:

merge styles
rename styles
delete unused styles
create missing styles
normalize typography size mapping
normalize neutral palette mapping
replace raw values with styles
apply corrected styles to layout


Nothing is executed automatically during the audit phase.


# Final Validation Model

After designer confirmation and before applying changes, run a final validation pass.


Verify:

no unresolved mappings remain
no active styles are being deleted by mistake
no missing dependencies remain
no conflicts were introduced by confirmed actions
no invalid rename or merge targets exist


# Execution Principles

Audit mode is planning-first.

Audit findings guide execution, but do not execute changes by themselves.

Only confirmed and validated actions may proceed to style-system update and layout application.

Domain-specific rules invoked during audit and execution are defined in:
- references/typography-extraction.md
- references/color-extraction.md
- references/scale-extension.md
- references/naming-convention.md
- references/accessibility-validation.md
