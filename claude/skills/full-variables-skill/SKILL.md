---
name: full-variables-skill
description: >
  Figma variables skill for creating, analyzing, and applying variables in real product
  files. Use whenever working with Figma variables, token structure, semantic variables,
  primitive variables, variable audits, variable naming, variable application, replacing
  hardcoded values with variables, or building variables from existing styles.
  Trigger on: figma variables, tokens, variable system, create variables, audit variables,
  apply variables, semantic tokens, primitive tokens, token naming, token hierarchy,
  replace styles with variables, normalize variables.
---

# Full Variables Skill

This skill is for **Figma variables only**.

It is not a general design-system skill.
It does not define file organization, component architecture, code handoff, or dark mode strategy.

The skill is responsible for:
- creating variables from scratch
- creating variables from existing styles and layout patterns
- auditing an existing variable system
- applying variables to the file after structure decisions are made

---

## 1. Purpose

Use this skill to build, review, and apply a variable system in Figma.

Core responsibilities:
- detect reusable values and roles
- define a variable structure
- create variables
- map values to variables
- apply variables to layers and layouts
- audit variable quality and coverage
- work safely in files where styles already exist

---

## 2. What this skill covers

### Included in v1
- variable creation from scratch
- variable creation from existing styles
- variable audit and analysis
- variable application in the file
- interaction between styles and variables
- all variable types used by the file, including:
  - colors
  - spacing
  - radius
  - typography-related variables
  - effects

### Explicitly excluded from v1
- dark mode and theme modes
- density modes
- multi-brand token systems
- file or page organization rules
- component architecture rules
- code export or handoff logic
- full migration framework as a separate operating mode

---

## 3. When to use this skill

Use this skill whenever the task involves any of the following:
- creating Figma variables
- reviewing an existing variable system
- replacing hardcoded values with variables
- building variables from styles already present in the file
- normalizing variable naming or collection structure
- identifying missing semantic variables
- applying variables across a layout or component set

Typical trigger phrases:
- create variables
- build variable system
- audit variables
- analyze token structure
- create semantic variables
- primitive vs semantic tokens
- replace styles with variables
- map styles to variables
- apply variables to file

---

## 4. Variable system model

Use a three-layer model:

```text
Primitive → Semantic → Component-specific (exception only)
```

### Primitive variables
Raw values.
Examples:
- color/blue/500
- spacing/4
- radius/md
- effect/shadow/sm

Primitive variables hold direct values.
They are not the preferred application layer for production UI.

### Semantic variables
Purpose-based variables.
Examples:
- bg/surface
- text/primary
- border/default
- action/primary/default
- icon/secondary

Semantic variables are the primary application layer.
Whenever a stable UI role exists, prefer semantic variables over primitives.

### Component-specific variables
Allowed only when justified.
Examples:
- input/ring
- tooltip/bg
- promo-banner/accent

Do not create component-specific variables by default.
Use them only when semantic variables cannot express the requirement cleanly.

---

## 5. Supported variable types

This skill supports all variable types relevant to the file.

### Color variables
Use for fills, strokes, text color, icon color, overlays, and semantic states.

### Spacing variables
Use for auto layout padding, gaps, and other repeatable spacing decisions.

### Radius variables
Use for repeatable corner radius values.

### Typography-related variables
Support when the file uses them or when the user explicitly wants them.
Treat carefully in mixed environments where text styles already carry typography structure.

### Effects variables
Support for shadows, overlays, blur-related patterns, and effect-like reusable values when present.
These are valid, but usually less common than color, spacing, or radius.

---

## 6. Variables ↔ Styles interaction

Styles and variables must be treated as compatible working layers.
Do not assume one fully replaces the other in every project stage.

### Working model
- early-stage projects may rely more on styles
- later-stage projects may rely more on variables
- hybrid states are normal

### Rules
- never ignore existing styles
- never silently override styles
- treat styles as input context when building variables
- variables may become the target layer for long-term consistency
- if styles already define usable roles, use them as mapping input
- do not break the style layer without confirmation

### Practical interpretation
When styles exist:
- inspect them first
- understand what roles they already express
- build variables on top of that logic where appropriate
- apply variables only after the structure is clear

---

## 7. Naming rules

Use predictable naming.

### Core rules
- lowercase only
- slash-separated naming
- names must describe purpose, not appearance
- state variants belong at the third level when state is needed
- comparable categories should follow comparable state patterns

### Good patterns
- text/primary
- bg/surface
- border/default
- action/primary/default
- action/primary/hover
- spacing/4
- radius/md

### Avoid
- Blue Primary
- red-hover
- Surface Gray 2
- Token 1
- Button Blue Active

### Important rule
Do not silently normalize unclear roles.
If a value is repeated but its semantic role is ambiguous, inspect usage before assigning a semantic name.

---

## 8. Collection structure rules

Use clear collection separation.

### Recommended structure
- primitive collections
- semantic collections
- component-specific collections only when justified

### Rules
- do not mix primitive and semantic roles in the same collection without a clear reason
- do not create component-specific collections unless the file actually needs them
- prefer stable, reusable structure over short-term convenience
- keep collection purpose obvious from naming

Because v1 excludes theme-mode strategy, collections in this version should focus on clean structure rather than mode expansion.

---

## 9. Operating modes

This skill works in three primary modes.

### A. Create from scratch
Use when:
- no usable variable system exists
- the user wants a clean rebuild
- current variables should be ignored or replaced

Workflow:
1. inspect the file
2. inspect styles if they exist
3. detect repeated values and repeatable roles
4. define primitive variables
5. define semantic variables
6. create variables
7. apply variables to the file
8. verify coverage and consistency

### B. Create from styles
Use when:
- styles already exist
- variables are absent or incomplete
- the user wants variables built from the existing file logic

Workflow:
1. inspect styles
2. inspect repeated values in the layout
3. identify roles already expressed by styles
4. define primitive variables where needed
5. define semantic variables from the style layer
6. create variables
7. apply variables carefully
8. verify mapping quality and unresolved cases

### C. Audit existing variables
Use when:
- variables already exist
- the user wants analysis, cleanup direction, or validation

Workflow:
1. inspect collections and variables
2. inspect how variables are applied
3. inspect the relationship between variables and styles
4. report findings by category
5. ask for confirmation before destructive or structural fixes
6. apply approved fixes
7. verify the result

---

## 10. Audit scopes

Audit is not a generic opinion pass.
It is a structured review across explicit categories.

### Audit categories

#### Structure
Check for:
- primitive and semantic layers mixed together
- unclear collection purpose
- inconsistent hierarchy
- weak separation between reusable roles and raw values

#### Naming
Check for:
- appearance-based names instead of purpose-based names
- inconsistent naming patterns
- broken state naming
- duplicate concepts with different names
- unclear or non-scalable naming

#### Coverage
Check for:
- repeated values in the file without variables
- missing semantic roles
- incomplete variable coverage in important UI areas
- file parts still dependent on local values or styles only

#### Application
Check for:
- variables created but not applied
- hardcoded values still present where variables should be used
- primitives applied directly where semantic variables should exist
- inconsistent application of equivalent variables

#### System quality
Check for:
- duplicate variables
- redundant variables
- component-specific variables created without justification
- low-value fragmentation of the variable layer

#### Styles compatibility
Check for:
- styles that can serve as input for variable creation
- styles that conflict with current variable structure
- mixed usage patterns that block consistent application
- places where styles and variables are out of sync

---

## 11. Apply workflow

Application is part of the skill, not a separate optional thought exercise.

### Apply stages
1. inspect current usage
2. decide target mapping
3. confirm when the replacement may be destructive or ambiguous
4. create missing variables if needed
5. apply variables
6. verify that important areas are covered correctly

### Apply targets
The skill may apply variables to:
- fills
- strokes
- text color
- icon color
- effects
- corner radius
- auto layout padding
- auto layout gaps
- typography-related variable bindings where relevant

### Safety rules
- no silent destructive replacement
- no semantic guess when the role is unclear
- no replacing styles blindly when they still act as a valid source layer
- if structure is ambiguous, inspect more before applying

---

## 12. Decision rules for new variables

Create a new variable when:
- the same value plays a stable reusable role
- repeated hardcoded use shows that a variable is missing
- an existing variable cannot express the role cleanly

Do not create a new variable when:
- the role is one-off and not meaningfully reusable
- a suitable existing semantic variable already exists
- a component-specific variable is being used to avoid proper semantic structure

### Heuristic
Repeated hardcoded values are often a sign that the system is missing a semantic variable.
However, repeated value alone is not enough.
Role consistency must also be confirmed.

---

## 13. Component-specific variables policy

Component-specific variables are allowed only as exceptions.

Use them when:
- the value would be wrong anywhere else
- the component needs a controlled, local abstraction
- the requirement cannot be expressed by the semantic layer without creating confusion

Do not use them:
- as the default modeling strategy
- to avoid fixing weak semantic naming
- when a reusable semantic role already exists

If unsure, prefer primitive + semantic first.

---

## 14. Output behavior

The skill should behave operationally.
It must not stop at generic commentary.

### In create flows
Expected response pattern:
1. identify existing situation
2. propose structure
3. highlight ambiguous areas
4. create variables
5. apply variables
6. verify result

### In audit flows
Expected response pattern:
1. report findings by audit category
2. separate confirmed problems from assumptions
3. identify safe fixes vs destructive changes
4. ask for confirmation when needed
5. apply approved fixes
6. verify result

### Communication rules
- be explicit about what is confirmed vs inferred
- group issues by category instead of listing random observations
- do not normalize or rename silently when ambiguity remains
- prioritize reusable structure over quick patching

---

## 15. Exclusions and limits in v1

This version of the skill does not define:
- dark mode systems
- multi-mode expansion logic
- brand-based token branching
- file/page documentation architecture
- component design best practices beyond what directly affects variable application
- code implementation details
- export pipelines
- full migration framework as an independent mode

Local cleanup and normalization may happen inside create or audit workflows.
But full migration planning is out of scope for v1.

---

## 16. Reference files

Use reference files for deeper architectural guidance.

Recommended references for this skill:
- `references/variables-architecture.md`
- `references/token-improvements.md`
- `references/figma-best-practices.md`

Suggested role of each file:
- `variables-architecture.md` → variable hierarchy, aliasing, naming, semantic structure
- `token-improvements.md` → when to add variables, missing-variable heuristics, system evolution
- `figma-best-practices.md` → only the parts relevant to variable usage, semantic binding, and anti-hardcoding rules