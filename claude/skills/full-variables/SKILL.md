---
name: full-variables
description: Creates, audits, extends, and applies Figma variables using a layered token architecture (primitive → semantic → component). Use when user asks to "create variables", "create variables from styles", "audit variables", "apply variables", "extend variable system", "find missing variables", "rebuild variables", "convert styles to variables", "fix variable structure", "normalize tokens", or mentions Figma variable system, design tokens, primitive/semantic/component layers, variable aliasing, or token migration. User intent (create vs audit vs apply vs extend vs rebuild) determines the workflow.
license: MIT
compatibility: Requires Figma file with editor access. Designed for planning-first, user-directed workflows on full files, pages, frames, or specific component scopes.
metadata:
  author: Vasyl
  version: 1.0.0
  target: figma-plugin
  category: design-tokens
  tags: [variables, design-tokens, figma, primitive-semantic-component, audit]
---

# Full Variables

Skill for creating, auditing, extending, and applying Figma variables using a layered token architecture.

The skill is **user-directed**: it interprets user intent and runs the corresponding workflow. It does not assume restructuring unless explicitly requested.


# Reference map

- Token hierarchy, naming, aliasing rules, collection structure, anti-patterns → `references/variables-architecture.md`
- Extension, deprecation, duplicate detection, patch vs migration, reuse threshold → `references/token-improvements.md`
- Real-world Figma usage, anti-hardcoding, state handling, accessibility roles, migration safety → `references/figma-best-practices.md`


# Operating Mode

Always run user-directed and planning-first.

The skill:

- interprets the user's intent from the request
- runs the intent-specific workflow
- never silently restructures the system
- never silently stops mid-workflow
- requires explicit confirmation for any broadly impactful or destructive change


For destructive operations (rebuild, mass deletion, primitive changes), always require explicit user confirmation before proceeding.


# Variable System Model

Three-layer architecture: **primitive → semantic → component**.


Only semantic and component variables are applied to layouts. Primitive variables are alias sources and must never be applied directly to UI nodes.


For full hierarchy rules, alias direction, naming format, collection structure, and anti-patterns see `references/variables-architecture.md`.


# Supported Variable Types

- color
- spacing
- radius
- opacity
- typography-related bindings (where applicable)
- effect variables (only when explicitly required)


# Naming Convention

Slash-based hierarchical naming:

```
category/type/role/state
```

Examples:

```
color/background/default
color/text/muted
spacing/container/padding
button/background/hover
```

Appearance-based naming is not allowed in the semantic layer (e.g. `color/light-gray-background` ❌).


For full naming policies (state suffixes, casing, anti-patterns) see `references/variables-architecture.md`.


# User Intents and Their Workflows

The skill determines the workflow from the user's instruction. Each intent runs its own multi-phase flow.


## Create variables (from scratch)

Phases:

1. layout analysis
2. structure proposal (primitive / semantic / component)
3. designer confirmation of structure
4. variable creation
5. apply review
6. apply confirmation (if changes are broad)
7. apply to layouts


A create task is **not complete after creation** — it must continue until apply is resolved (see Phase Completion Rules below).


## Create variables from styles

Phases:

1. style inspection (text, fill, effect, grid styles)
2. semantic mapping proposal (which style → which semantic variable)
3. designer confirmation
4. variable creation
5. apply review
6. apply confirmation (if needed)
7. apply to layouts


Styles act as extraction sources, not as parallel systems. In v1, styles are NOT auto-deleted after migration — they are preserved until variable coverage is verified.


For migration safety and styles-to-variables transition rules see `references/figma-best-practices.md` and `references/variables-architecture.md`.


## Audit variables

Analysis-only phases:

1. inspect existing variables and collections
2. detect issues per the Audit Scope (see below)
3. report findings with severity
4. propose resolutions


Audit ends after findings are returned. No modifications happen without a follow-up create / extend / apply / rebuild request.


## Apply variables

Map existing variables to layout nodes. No system restructuring unless required and explicitly confirmed.


Apply order:

1. replace hardcoded values
2. replace duplicated styles where variable mapping is intended
3. normalize semantic bindings
4. introduce component variables only if needed


For full apply discipline and refactoring order see `references/figma-best-practices.md` (variable refactoring discipline).


## Extend variables

Add missing semantic or component roles. Do not rebuild unrelated parts of the system.


For detection signals of missing variables, the reuse threshold rule, and over-segmentation warnings see `references/token-improvements.md`.


## Rebuild variables

Replace structure only when the user explicitly requests rebuild OR confirms destructive changes.


This is the only intent that may delete or restructure existing variables at scale. Always require explicit destructive confirmation. Before proceeding, restate scope and impact, and offer a patch alternative if appropriate (see `references/token-improvements.md` for patch vs migration decisions).


# Audit Scope

Audit checks for:

- primitive vs semantic separation
- missing semantic roles
- duplicate variables
- hardcoded values
- inconsistent naming
- invalid alias direction (component → primitive, semantic → component, etc.)
- style / variable conflicts


For duplicate detection patterns, alias direction rules, and anti-patterns see `references/variables-architecture.md` and `references/token-improvements.md`.


# Phase Completion Rules

For **audit-only** intents:

task ends after findings are returned.


For **create-related** intents (create, create-from-styles):

task continues until apply is **resolved**.


"Apply resolved" means one of:

- variables were applied to layouts
- the user explicitly declined apply
- the user requested creation only, without apply


The skill must never silently stop after variable creation if apply is the expected final phase.


After each major phase, the skill must state:

- current status
- next expected step


After variable creation specifically, the skill must explicitly say one of:

- "variables created, next step is apply"
- "apply confirmed, proceeding to layout application"
- "apply was declined, task ends after creation"


# Decision Rules for New Variables

When introducing a new variable:

1. check existing semantic roles
2. reuse if possible
3. create a semantic variable if the meaning is reusable
4. create a component variable if scope is local
5. avoid creating primitives unless defining raw values


For the full decision tree, reuse threshold rule, and over-segmentation guidance see `references/token-improvements.md`.


# Component Variables Policy

Component variables are allowed only when semantic reuse is not expected.


If reuse expands across multiple components: promote the role into the semantic layer.


For component isolation principle and promotion criteria see `references/variables-architecture.md`.


# Apply and Migration Safety

Apply variables only to nodes where the binding is semantically valid.


Never:

- delete styles silently during migration
- rebuild collections without explicit user request
- modify primitives unless required
- replace semantic layers without confirmation
- remove deprecated variables before usage is fully replaced


For migration safety, deprecation flow, and patch-vs-migration decisions see `references/figma-best-practices.md` and `references/token-improvements.md`.


# Output Behavior

The skill returns:

- variable structure proposals
- missing variable detection
- naming corrections
- alias recommendations
- apply sequences
- migration guidance when required


# v1 Exclusions

This skill does NOT:

- auto-delete styles
- restructure typography systems automatically
- rebuild token hierarchies without confirmation
- modify primitives unless explicitly required


# Examples

## Example 1: Create variables from scratch

User says: "Create variables for this layout."

Actions:

1. Analyze the layout for reusable roles (backgrounds, text, borders, spacing).
2. Propose primitive + semantic + component structure.
3. Wait for designer confirmation of structure.
4. Create variables in collections (Primitives / Semantics / Components).
5. Present apply review.
6. On confirmation, apply variables to layout nodes.
7. State final status: "applied to N nodes" or "apply declined, task complete."

Result: Three-layer variable system created and bound to the layout (or just created, if apply was declined).


## Example 2: Convert styles to variables

User says: "Convert these styles into variables."

Actions:

1. Inspect existing styles (fill, text, effect).
2. Propose semantic mapping (e.g., `Background/Default` style → `color/background/default` semantic variable).
3. Wait for designer confirmation.
4. Create semantic variables aliased to primitives.
5. Apply review: which nodes will be re-bound from styles to variables.
6. On confirmation, rebind nodes.
7. Styles remain in the file (NOT auto-deleted in v1).

Result: Variables created from styles. Styles preserved as extraction source until variable coverage is verified.


## Example 3: Audit only

User says: "Audit the variable system in this file."

Actions:

1. Inspect collections and variables.
2. Detect: missing semantic roles, duplicates, hardcoded values, naming inconsistencies, invalid alias direction, style/variable conflicts.
3. Return findings with severity and suggested resolutions.
4. End. No modifications.

Result: Audit report. Designer decides whether to follow up with extend / rebuild / apply.


## Example 4: Extend without rebuild

User says: "Add missing focus border and muted text variables."

Actions:

1. Verify the requested roles do not already exist.
2. Propose `color/border/focus` and `color/text/muted` with primitive aliases.
3. Wait for confirmation.
4. Create only the requested variables.
5. Offer apply review for nodes that should adopt the new roles.

Result: Two new semantic variables added. Existing system untouched.


## Example 5: Rebuild — destructive change confirmation

User says: "Rebuild the variable system from scratch."

Actions:

1. Restate scope explicitly: "This will replace existing collections, semantics, and component variables. Are you sure? A patch may be safer if the current structure is mostly correct."
2. Wait for explicit destructive confirmation.
3. Only after confirmation, proceed with rebuild flow (analysis → proposal → confirmation → creation → apply).

Result: System rebuilt only after explicit user confirmation. No silent destructive change.


# Troubleshooting

## Variables created, but no apply happened

Cause: The skill stopped after variable creation, violating phase completion rules.

Solution: After creation, the skill must explicitly transition to apply review and state "variables created, next step is apply." If apply was missed, re-trigger with: "Apply the created variables to the layout."


## Hardcoded values still present after apply

Cause: Apply did not reach all nodes, or some values had no matching semantic variable.

Solution: Run audit intent to surface remaining hardcoded values. For each, decide: create a new semantic variable (if reuse exists) or accept as a local exception. See `references/token-improvements.md` (reuse threshold rule).


## Duplicate variables detected

Cause: Same meaning expressed by two variable names (e.g., `color/text/default` and `color/font/default`), or styles + variables holding the same role.

Solution: Use audit intent to identify duplicates. Resolve via deprecation flow: mark old variable as deprecated → replace usage → remove only after coverage is complete. See `references/token-improvements.md` (deprecation strategy).


## Component variable references a primitive directly

Cause: Skipping the semantic layer in the alias chain.

Solution: This violates alias direction (must be primitive → semantic → component). Insert a semantic variable between the primitive and the component variable. See `references/variables-architecture.md` (alias strategy).


## User asks "rebuild" but the system is mostly fine

Cause: Rebuild is destructive. A patch may be sufficient.

Solution: Before running rebuild, ask whether a patch (extend + audit fixes) would be safer. See `references/token-improvements.md` (migration vs patch decisions). Run rebuild only if user confirms after this clarification.


## Style still applied to nodes after variable creation

Cause: In create-from-styles flow, nodes were not rebound during apply phase.

Solution: Apply phase must include rebinding. If apply was declined, styles remain (intentional in v1 — no auto-delete). To rebind manually, run "apply variables" intent.


## Over-segmentation: too many narrow semantic variables

Cause: Creating semantic variables for nearly identical roles (e.g., `color/background/card-light`, `color/background/card-default`, `color/background/card-normal`).

Solution: Consolidate into one semantic role unless real behavioral differences exist. See `references/token-improvements.md` (over-segmentation warning).
