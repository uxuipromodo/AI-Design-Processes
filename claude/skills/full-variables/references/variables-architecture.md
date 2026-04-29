# Variables Architecture Reference

This document defines the structural model of the variable system used inside the Full Variables Skill.

It establishes the hierarchy, naming logic, aliasing rules, and decision criteria for creating, extending, and maintaining variables in Figma.


## 1. Token hierarchy

For real-world Figma usage discipline (anti-hardcoding, state handling,
migration safety) see:

references/figma-best-practices.md

For extension, deprecation, duplicate detection, and patch-vs-migration
guidance see:

references/token-improvements.md

The variable system follows a three-layer structure:

1. Primitive layer
2. Semantic layer
3. Component-specific layer

Hierarchy direction:

primitive → semantic → component

Only semantic and component variables should be applied to UI layouts.

Primitive variables must never be applied directly to components or screens.


## 2. Primitive layer

Primitive variables define raw visual values.

Examples:

color/blue/500
color/gray/100
spacing/4
spacing/8
radius/4
opacity/40

Primitive variables:

- represent absolute values
- never describe purpose
- never include states
- never reference components
- are used only as alias sources

Primitive variables must remain stable and reusable across the entire system.


## 3. Semantic layer

Semantic variables define meaning and usage context.

Examples:

color/background/default
color/background/subtle
color/text/default
color/text/muted
color/border/default
color/border/focus

Semantic variables must:

- reference primitive variables
- describe intent instead of appearance
- remain component-independent
- support state extensions if needed

Example:

color/text/default → color/gray/900


## 4. Component-specific layer

Component-specific variables define behavior inside UI components.

Examples:

button/background/default
button/background/hover
button/text/default
input/border/focus
card/background/default

Component variables must:

- reference semantic variables
- never reference primitives directly
- remain scoped to a component context

Example:

button/background/default → color/background/default


## 5. Alias strategy

Aliasing must always follow this direction:

primitive → semantic → component

Never allow:

component → primitive
semantic → component

Correct example:

color/gray/900
→ color/text/default
→ button/text/default


## 6. Collection structure

Variables must be grouped into logical collections.

Recommended structure:

Primitives
Semantics
Components

Alternative allowed structure:

Color primitives
Spacing primitives
Radius primitives
Semantic colors
Semantic spacing
Component variables

Collections must reflect system scale and team workflow complexity.


## 7. Naming conventions

Variables must follow slash-based hierarchical naming:

category/type/role/state

Examples:

color/background/default
color/background/hover
spacing/container/padding
radius/button/default

Naming must:

- be lowercase
- avoid appearance-based wording
- avoid raw color names inside semantic layer
- avoid component references inside semantic layer


## 8. State expansion rules

State suffixes must be added only when interaction requires them.

Allowed states:

default
hover
active
focus
disabled
pressed
selected

Example:

button/background/default
button/background/hover
button/background/pressed

Avoid creating unnecessary states.


## 9. When to create a new semantic variable

Create a new semantic variable if:

multiple components reuse the same intent

Example:

card background
modal background
dropdown background

Should become:

color/background/surface


Create component-specific variables if:

the value applies to only one component

Example:

button/destructive/background


## 10. Minimum semantic variable set

Each system should define at least:

color/background/default
color/background/subtle
color/background/surface

color/text/default
color/text/muted
color/text-inverse/default

color/border/default
color/border/subtle
color/border/focus

color/fill/primary
color/fill/secondary
color/fill/destructive

spacing/container/padding
spacing/component/gap

radius/component/default
radius/container/default


## 11. Styles interaction model

Styles may exist during early project stages.

Variables become the final source of truth during system stabilization.

Migration flow:

styles → semantic variables → component variables

When styles exist:

they should be used as extraction sources

When variables exist:

styles must not duplicate variable logic

For the full migration workflow (do-not-delete-immediately, gradual replacement,
post-migration cleanup) see:

references/figma-best-practices.md (migration safety rules)


## 12. Direct primitive usage exceptions

Primitive variables may be applied directly only if:

the system is in early exploration stage
or semantic structure is not yet defined

This usage must be temporary.


## 13. Component isolation principle

Component variables must never leak outside their component scope.

Example:

button/background/default

must not be reused by:

card
modal
tooltip

Instead:

create semantic aliases if reuse emerges.


## 14. Variable creation decision tree

When introducing a new variable:

Step 1:

Check whether a semantic variable already exists

Step 2:

If reused across components → create semantic variable

Step 3:

If scoped to one component → create component variable

Step 4:

If raw value only → create primitive variable


## 15. Anti-patterns

Avoid:

semantic variables referencing semantic variables unnecessarily

component variables referencing primitives

appearance-based semantic names

example:

color/blue-primary
color/light-gray-border


## 16. System stability rule

Primitive layer changes are high-risk

Semantic layer changes are medium-risk

Component layer changes are low-risk

Always modify the lowest-impact layer possible.
