Figma Best Practices Reference

This document defines how variables should be created, applied, and maintained inside Figma when using the Full Variables Skill.

It ensures consistency between system architecture and real layout usage.

1. Design tokens architecture

Variables must follow a layered token structure:

primitive → semantic → component

Primitive variables define raw values.

Semantic variables define reusable meaning.

Component variables define behavior inside components.

Only semantic and component variables should be applied to UI layouts.

Primitive variables must not be applied directly to interface elements.

2. Variable creation workflow

Variables must be introduced in a controlled sequence.

Recommended workflow:

Step 1:

identify reusable roles inside the layout

Step 2:

check whether semantic variables already exist

Step 3:

reuse existing variables if possible

Step 4:

create semantic variables if reuse is expected

Step 5:

create component variables only if scope is local

Avoid creating variables directly from visual appearance.

3. Semantic binding rules

Semantic variables must describe purpose, not color or size.

Correct:

color/background/default

Incorrect:

color/light-gray-background

Correct:

color/text/muted

Incorrect:

color/gray-400-text

Semantic naming must remain stable even if visual values change later.

4. Anti-hardcoding rules

Hardcoded values should be avoided wherever a reusable role exists.

Hardcoding is acceptable only when:

the layout is still exploratory

the semantic structure is not yet defined

the value appears only once

Hardcoded values must be replaced once reuse appears.

5. Variable usage constraints

Variables must be applied consistently across:

fills
strokes
text colors
spacing
radius
opacity

Avoid mixing:

styles + variables + raw values

inside the same role without hierarchy.

6. Styles interaction expectations

Styles may exist during early project stages.

Variables become the primary system layer during stabilization.

Allowed workflow:

styles → semantic variables → component variables

Styles should act as extraction sources, not permanent parallel systems.

Avoid maintaining duplicate logic in both styles and variables.

7. Collection organization rules

Collections should reflect logical system layers.

Recommended collections:

Primitives

Semantics

Components

Avoid mixing primitive and semantic variables inside one collection.

8. Alias consistency expectations

Aliasing must follow:

primitive → semantic → component

Never allow:

component → primitive

Example:

color/gray/900
→ color/text/default
→ button/text/default

Incorrect alias direction increases system fragility.

9. State variable handling

States should be created only when interaction requires them.

Allowed states:

default
hover
active
focus
pressed
disabled
selected

Avoid creating unused interaction states.

10. Spacing variable usage

Spacing variables should represent layout logic rather than pixel values.

Correct:

spacing/container/padding

Incorrect:

spacing/16

Spacing primitives may exist, but layouts should reference semantic spacing roles.

11. Radius variable usage

Radius variables should reflect component roles.

Correct:

radius/component/default

Incorrect:

radius/6

Primitive radius values may exist but should not be applied directly in layouts.

12. Opacity variable usage

Opacity variables should be introduced only when reused across elements.

Examples:

opacity/disabled

opacity/subtle

Avoid creating opacity variables for single-use adjustments.

13. Accessibility expectations

Variables should support readable contrast and visible interaction feedback.

Important semantic roles:

color/text/inverse

color/text/muted

color/background/surface

color/border/focus

These roles help prevent accessibility regressions later.

14. Component isolation expectations

Component variables must remain scoped to their component.

Example:

button/background/default

must not be reused outside button logic.

If reuse appears across multiple components:

promote the role into semantic level.

15. Variable refactoring discipline

When improving an existing layout:

replace hardcoded values first

replace duplicated styles second

normalize semantic variables third

introduce component variables last

This order prevents unnecessary restructuring.

16. Migration safety rules

When transitioning from styles to variables:

do not delete styles immediately

extract semantic roles first

replace usage gradually

remove styles only after variable coverage is complete

This prevents layout breakage during migration.

17. Scaling expectation

As the system grows:

semantic variables should increase slowly

component variables should increase naturally

primitive variables should remain stable

If primitives change frequently, the system architecture is unstable.
