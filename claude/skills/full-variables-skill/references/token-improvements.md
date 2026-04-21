Token Improvements Reference

This document explains how to extend, refine, and stabilize a variable system inside the Full Variables Skill.

It is used when the system already exists or when new variables must be added during growth of the project.

1. Adding semantic variables

A new semantic variable should be created when a reusable design meaning appears across multiple elements.

Typical examples:

* the same background role appears in cards, modals, and dropdowns
* the same text role appears in titles, labels, and helper text
* the same border role appears in inputs, cards, and containers

Create a semantic variable when:

* the meaning is reusable
* the variable describes intent, not appearance
* the same role appears in more than one place

Do not create a new semantic variable when:

* an existing one already matches the role
* the value is only local to one component
* the distinction is visual only, not functional

2. Detecting missing variables

A missing variable is usually revealed by one of these signals:

* designers repeatedly apply the same raw value manually
* styles exist, but there is no matching variable
* similar components use the same visual role with separate values
* hardcoded values appear in places where a reusable role clearly exists

Common examples of missing variables:

* text color for muted copy
* border color for focus states
* subtle background surfaces
* component gap spacing reused across layouts
* reusable radius values for containers or interactive elements

If a value appears repeatedly with the same meaning, that is a strong signal a variable is missing.

3. Accessibility-related variables

Even in v1, the system should reserve space for variables that support usability and accessibility.

Examples:

* color/border/focus
* color/text/inverse
* color/text/muted
* color/background/surface
* color/fill/destructive

These variables help avoid hardcoded fixes later.

Accessibility-related variables should be added early when:

* focus states need to be visible
* inverse text appears on colored fills
* subtle surfaces require enough contrast from the page background
* muted or secondary text appears often

Do not postpone these roles until the file becomes inconsistent.

4. Component-specific variables

Component-specific variables are allowed only when semantic variables are not enough.

Use component-specific variables when:

* the variable is truly limited to one component
* the component has a role not shared elsewhere
* the value would be misleading if promoted to semantic level

Examples:

button/background/hover
input/border/focus
badge/fill/default

Do not create component-specific variables when:

* the same meaning already exists semantically
* the value is likely to spread across multiple components
* the variable is being used just to mirror current component names

If reuse begins to spread, promote the logic upward into the semantic layer.

5. Deprecation strategy

When a variable is no longer correct or no longer needed, it should not disappear immediately without control.

Recommended deprecation flow:

1. mark the variable as deprecated in description or documentation
2. stop creating new usage of it
3. replace active usage with the correct variable
4. remove it only after usage is fully gone

Deprecation is needed when:

* two variables represent the same meaning
* a temporary variable was created during exploration
* naming was corrected and old names should be retired
* a component-specific variable became semantic or vice versa

Never remove variables blindly if they may still be applied in the file.

6. Migration vs patch decisions

Not every problem requires a full restructure.

Use a patch when:

* only a few variables are missing
* naming is mostly consistent
* semantic structure already works
* only local cleanup is needed

Use a migration when:

* primitives and semantics are mixed
* naming patterns are broken at scale
* variables duplicate styles without logic
* many variables are appearance-based
* the structure blocks future growth

Patch = local correction

Migration = structural correction

For Full Variables Skill v1, prefer patch logic first unless the user explicitly asks to rebuild the system.

7. Reuse threshold rule

A variable should usually stay local until reuse is clear.

Practical rule:

* used once = keep local or component-scoped
* used across multiple components = consider semantic
* used system-wide = semantic is strongly preferred

This rule prevents overbuilding the system too early.

8. Duplicate variable detection

Duplicate variables appear when:

* different names point to the same meaning
* different layers of the system store the same role
* old variables were kept after restructuring
* styles and variables duplicate one another without clear responsibility

Examples of duplicate risk:

color/text/default
color/font/default

button/background/default
color/fill/primary
when both are used for the same purpose without a clear hierarchy

Duplicates should be reviewed and resolved instead of preserved indefinitely.

9. Over-segmentation warning

Do not split variables too aggressively.

Bad pattern:

creating many narrowly scoped semantic variables for nearly identical roles

Example:

color/background/card-light
color/background/card-default
color/background/card-normal
color/background/basic-card

This creates noise instead of clarity.

Prefer fewer, stable semantic roles unless real behavioral differences exist.

10. Stability guidance

When refining the system, prefer the smallest safe change.

Risk by layer:

* primitive changes = high impact
* semantic changes = medium impact
* component-specific changes = lower impact

Whenever possible:

* fix the issue at the highest safe layer
* avoid changing primitive values unless the entire system truly depends on that correction
* avoid creating new layers of aliasing without need

11. Improvement checklist

When improving an existing variable system, check:

* are primitive and semantic roles clearly separated?
* are there missing reusable semantic roles?
* are component-specific variables justified?
* are raw values still being used where variables should exist?
* are there duplicates?
* are styles acting as source material or as conflicting parallel logic?
* is the naming consistent?
* is the system getting simpler or more fragmented?

If a change makes the system harder to understand, it is probably the wrong change.

12. Decision summary

When a new need appears:

1. check existing semantic variables
2. reuse if possible
3. create a new semantic variable if the meaning is reusable
4. create a component-specific variable only if scope is truly local
5. avoid hardcoded fallback unless it is a temporary exploration step
6. prefer patch over migration unless the structure is fundamentally broken
