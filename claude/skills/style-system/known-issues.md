# Known Issues — Style System Skill

Виявлені проблеми скіла після реального прогону на проєкті Estro.ua Redesign (2026-05-06).
Кожен пункт — самостійна задача на доробку. Можна брати в роботу окремо.

Контекст інциденту: PHASE 1–4 виконано, користувач помітив прогалини і змусив доробляти у 3 додаткових ітерації (~30% роботи поза основним flow).

---

## ISSUE-1: Apply skip-rule надто широко покриває VECTOR

### Симптом
49 VECTOR-вузлів у бренд-кольорі `#861515` (логотип, серце, плюс, чекбокси) залишилися raw після Step 4.2, хоча `Accent/Primary` стиль існував і явно мав їх покрити. Користувач помітив візуально і сказав «червоні стилі не застосовано».

### Корінна причина
Правило в `references/color-extraction.md` сформульоване категорично:

> Never apply background color styles automatically to:
> - VECTOR nodes
> - BOOLEAN_OPERATION nodes
> - GROUP nodes
> - frames whose children are only vectors or icons
> - nodes whose names indicate logo or icon

Контекст правила — захист від випадкового перефарбовування іконок прапорів країн і чужих логотипів. Але формулювання `Never apply ... to VECTOR nodes` не розрізняє:
- VECTOR з зовнішнім кольором (прапор країни, логотип чужого бренду) — **MUST skip**
- VECTOR із SOLID-fill у бренд-кольорі (іконка з палітри) — **MUST apply**

Я в Step 4.2 застосував whole-list skip (`SKIP_TYPES = {VECTOR, BOOLEAN_OPERATION, ...}`) до всіх fills, не лише до background. У результаті бренд-іконки втратили стиль.

### Запропоноване виправлення в скілі

`references/color-extraction.md` → секція **Apply Safety Rules**, додати:

```
# Apply Safety Rules — VECTOR exception for brand colors

VECTOR / BOOLEAN_OPERATION nodes MAY receive a fill style if:
  - the node has exactly one SOLID fill
  - the fill color hex matches a color in the project's Accent or Neutral palette
  - the node name does NOT match: /flag|country|external/i

For all other VECTOR fills (external logos, country flags, decorative
illustrations) skip remains the default.
```

Фактично: skip-list із whitelist по hex-палітрі.

### Test case
Прогнати скіл на Estro Redesign (file `veXHow34TGCG3K5k0ScLvj`, page node `16017:80085`).
**Очікуваний результат:** після Step 4.2 кількість непокритих VECTOR з hex `#861515` має бути 0. Прапори країн (`#0057B7`, `#FFD700` тощо) залишаються raw.

---

## ISSUE-2: PHASE 2 preview приймає рішення за дизайнера для поодиноких сигнатур

### Симптом
Заголовок сторінки товару «В'язаний коричневий кардиган Estro ER00117939» (Source Sans Pro Regular 26, lh 110%) залишився без text style. Те саме з 24/22/20/28px Regular і SemiBold 34. Користувач помітив візуально на 4-й ітерації.

### Корінна причина
PHASE 1 audit коректно знайшов усі сигнатури і їхні `name` атрибути (включно з очевидними heading-іменами типу `"В'язаний коричневий кардиган..."`). Але PHASE 2 preview запропонував лише 10 канонічних стилів і скинув решту під заголовок «Орфани (доцільно нормалізувати або зберегти як винятки)» БЕЗ окремого `AskUserQuestion`.

`SKILL.md` явно вимагає протилежне:

> Non-canonical sizes (not divisible by 2px) must stop in planning mode with explicit options. Never snap silently.

Але:
1. 26/24/22/20/28px — **canonical** (divisible by 2). Правило про non-canonical їх не покриває.
2. Скіл не має правила «every signature with semantic name MUST be presented for explicit decision».
3. `audit-principles.md` перелічує `create missing styles` серед confirmable actions, але не вимагає окремого питання per signature.

У результаті семантичні headings зникли в купі «винятків» і не отримали стилю.

### Запропоноване виправлення в скілі

`references/typography-extraction.md` → нова секція:

```
# Per-Signature Decision Rule (PHASE 2)

In PHASE 2 preview, every unique typography signature with usage ≥ 1
MUST receive an explicit decision in the output:

1. covered by a system style (rename / merge / new)
2. exception (kept raw, with reason)
3. dropped (not present in any node — only from prior style library)

Signatures with semantic node names matching /heading|title|h\d|price|cta|
button|label/i MUST get an explicit AskUserQuestion option, even if usage = 1.

Frequency is NOT sufficient grounds to drop a signature. Semantic intent
overrides frequency.
```

`SKILL.md` → секція **Preview Output Requirements**, додати рядок:
```
- explicit per-signature decision table (no implicit "exceptions" bucket)
```

### Test case
Прогнати на Estro Redesign. **Очікуваний результат:** PHASE 2 preview містить рядок про сигнатуру `Source Sans Pro Regular 26 / 110% / "В'язаний коричневий кардиган..."` з пропозицією створити `Heading/Regular 26`. Користувач явно підтверджує/відхиляє.

---

## ISSUE-3: Немає post-apply verification

### Симптом
Після завершення Step 4.2 я звітував про "успіх" зі статистикою `applied: 320, skipped: 132`. Не верифікував, скільки з пропущених — це бренд-кольори, які мали отримати стиль. Прогалини виявив тільки користувач, після чого пішли 3 ітерації доробки.

### Корінна причина
Workflow скіла:
- PHASE 1 — audit
- PHASE 2 — confirm
- PHASE 3 — final validation **before** execute
- PHASE 4 — execute

PHASE 3 у `audit-principles.md`:

> Run one more validation pass after designer confirmation and before execution.
> Verify: no unresolved mappings remain ...

Це валідація **плану**, не **результату**. Скіл припускає: якщо план валідний → apply теж валідний. Але safety rules і matching logic у Step 4.2 знімають частину apply навіть із валідного плану. Жодне правило скіла не вимагає звіту про прогалину перед закриттям.

### Запропоноване виправлення в скілі

`SKILL.md` → додати **PHASE 5 — POST-APPLY VERIFICATION**:

```
PHASE 5 — POST-APPLY VERIFICATION (mandatory)

After Step 4.2 completes, run a verification pass via use_figma:

1. Find all TEXT nodes within audit scope without textStyleId.
   For each, check: does its (family, weight, size) match any style created
   in Step 4.1? If yes → bug, list the node.

2. Find all nodes with single SOLID fill within audit scope without fillStyleId.
   For each, check: does its hex match any paint style created in Step 4.1?
   If yes → bug, list the node.

3. If any bugs found:
   - report them to the designer with node IDs and proposed fix
   - offer to apply the fix in a follow-up step
   - DO NOT close the skill with success status

4. Only if both checks return zero bugs → report success and close.

This step is non-skippable. Skipping leads to silent ~30% incomplete apply.
```

`audit-principles.md` → додати PHASE 5 до **Workflow Model** після PHASE 4.

### Test case
Прогнати на Estro Redesign. **Очікуваний результат:** перед закриттям скіла бачимо рядок типу:
```
Post-apply verification: 0 bugs.
- TEXT nodes without style matching system: 0
- Solid fills without style matching system: 0
```
Якщо ненульові — список вузлів і пропозиція доробити.

---

## Загальний висновок

Усі три помилки — наслідок одного pattern: **скіл припускає, що "якщо валідний план виконано → результат валідний"**. На практиці apply-фаза має власні фільтри (safety rules, matching logic), які створюють прогалини. Скіл не має ні правила «явне рішення per signature», ні post-apply верифікації, тож прогалини проходять у фінальний звіт як "success".

Виправлення трьох issues разом дасть скіл, який гарантує 100% покриття або явно звітує про неможливість покриття з конкретними причинами.

---

## Status

| Issue | Priority | Status |
|---|---|---|
| ISSUE-1: VECTOR brand-color whitelist | High | Open |
| ISSUE-2: Per-signature decision in PHASE 2 | High | Open |
| ISSUE-3: PHASE 5 post-apply verification | High | Open |

Виправлення робити в порядку 3 → 2 → 1, бо PHASE 5 саме по собі вже виявить більшість прогалин і зменшить ризик регресії після правок 1 і 2.
