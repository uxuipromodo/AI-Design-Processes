---
name: full-variables
description: Skill for creating, auditing, extending, and applying Figma variables using a structured token architecture based on primitives, semantics, and component-level roles.
---

# Full Variables Skill

## 1. Purpose

This skill supports structured creation, analysis, extension, and application of Figma variables using a layered token architecture:

primitive → semantic → component

The skill follows user-directed intent rather than automatic workflow selection.

## 2. What this skill covers

This skill supports:

creating variables from scratch

creating variables based on styles

auditing existing variable systems

extending semantic structure

detecting missing variables

applying variables to layouts

stabilizing variable hierarchy

## 3. When to use this skill

Use this skill when:

a layout has no variables

variables exist but structure is unclear

styles must be converted into variables

variables must be applied consistently

semantic structure must be extended

missing variables must be identified

## 4. Variable system model

The skill follows a three-layer architecture:

primitive variables define raw values

semantic variables define reusable intent

component variables define scoped behavior

Only semantic and component variables should be applied to layouts.

## 5. Supported variable types

The skill supports:

color variables

spacing variables

radius variables

opacity variables

typography-related bindings where applicable

effect variables when explicitly required

## 6. Variables ↔ Styles interaction

Styles may exist during early stages.

Variables become the final system source of truth during stabilization.

Allowed transition:

styles → semantic variables → component variables

Styles should act as extraction sources, not parallel systems.

## 7. Naming rules

Variables must follow hierarchical slash-based naming:

category/type/role/state

Examples:

color/background/default

color/text/muted

spacing/container/padding

Appearance-based naming is not allowed in semantic layers.

## 8. Collection structure rules

Recommended collections:

Primitives

Semantics

Components

Collections must reflect token hierarchy rather than file structure.

## 9. User-directed task model

The user defines the action.

The skill interprets intent from the instruction provided with the Figma link or request text.

The skill must not assume restructuring unless explicitly requested.

## 10. Supported user intents

Examples of supported requests:

“Create variables”

“Create variables from styles”

“Audit variables”

“Apply variables”

“Extend variable system”

“Find missing variables”

“Rebuild variables from scratch”

## 11. Intent interpretation rules

The skill determines workflow from user instruction.

If the request is:

create variables → build semantic structure

audit variables → analyze only

apply variables → map variables to layout

extend variables → add missing roles

rebuild variables → replace structure if confirmed

## 12. Audit scopes

Audit includes checking:

primitive vs semantic separation

missing semantic roles

duplicate variables

hardcoded values

inconsistent naming

invalid alias direction

style-variable conflicts

## 13. Apply workflow

Apply workflow follows this order:

replace hardcoded values

replace duplicated styles

normalize semantic bindings

introduce component variables if needed

## 14. Decision rules for new variables

When introducing a new variable:

check existing semantic roles

reuse if possible

create semantic if reusable

create component variable if local

avoid primitives unless defining raw values

## 15. Component-specific variables policy

Component variables are allowed only when semantic reuse is not expected.

If reuse expands:

promote logic into semantic layer.

## 16. Output behavior

The skill returns:

variable structure proposals

missing variable detection

naming corrections

alias recommendations

apply sequences

migration guidance when required

## 17. Destructive change policy

The skill must not:

remove variables

replace semantic layers

rebuild collections

unless explicitly requested by the user.

## 18. Exclusions and limits in v1

This skill does not:

auto-delete styles

restructure typography systems automatically

rebuild token hierarchies without confirmation

modify primitives unless required

## 19. Reference files

See:

references/variables-architecture.md

references/token-improvements.md

references/figma-best-practices.md
