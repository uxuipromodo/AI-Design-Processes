# AI Design Processes

Skills для Claude Code: автоматизація роботи з Figma — стилі, variables, імпорт вебсторінок.

## Quick Start

### 1. Встановити Claude Code

```bash
curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
claude
```

При першому запуску: обери тему → **Log in with Claude account** → авторизуйся в браузері → підтверди системні дозволи macOS (тільки доступ до файлів — фото/контакти/календар відхиляй).

> Потрібен платний акаунт: Pro, Max, Team або Enterprise.

### 2. Встановити Figma MCP

```bash
claude mcp add --scope user --transport http figma https://mcp.figma.com/mcp
```

Перезапусти Claude Code → введи `/mcp` → знайди `figma` → **Authenticate** → **Allow Access** в браузері.

### 3. Увімкнути MCP у Figma Desktop

У файлі Figma Desktop: `Shift + D` → у правій панелі натисни **Enable desktop MCP server**.

### 4. Встановити офіційні Figma skills

В Claude Code введи запит:

```
Встанови офіційні Figma skills з https://github.com/figma/mcp-server-guide у ~/.claude/skills/
```

### 5. Встановити UXi skills

```bash
git clone https://github.com/uxuipromodo/AI-Design-Processes.git /tmp/ai-skills && bash /tmp/ai-skills/install.sh
```

### 6. Перевірити встановлення

```bash
ls ~/.claude/skills/
```

В Claude Code: `/mcp` (статус `figma`) і `/` (список skills).

---

## Available Skills

- `/style-system` — аналіз і нормалізація стилів у Figma
- `/full-variables` — побудова variables-архітектури
- `/import-webpage-to-figma` — імпорт вебсторінок як frame у Figma

[Детальна інструкція →](./README-full.md) · [Notion гайд →](#)

---

## Available Skills

### Style System

Аналізує Figma файл, знаходить всі використані шрифти та кольори, прибирає дублікати, будує нормалізовану систему стилів і застосовує її до нод.

**Коли використовувати:**
- у файлі хаос зі стилями або їх немає взагалі
- є багато схожих розмірів шрифтів або відтінків кольорів
- потрібно підготувати файл до побудови variables

**Що робить:**
- сканує всі текстові ноди і знаходить використані шрифти
- кластеризує розміри в ролі: Heading, Body, Action, Label
- збирає всю палітру кольорів (включно з raw fills на нодах)
- виявляє дублікати та майже-дублікати
- перевіряє контрастність за WCAG
- пропонує нормалізовану систему іменування
- застосовує стилі тільки після твого підтвердження

**Як запустити:**

```
/style-system

Figma: https://www.figma.com/design/FILE_KEY/...
```

або з уточненням режиму:

```
/style-system

Figma: https://www.figma.com/design/FILE_KEY/...
Режим: тільки аналіз
```

```
/style-system

Figma: https://www.figma.com/design/FILE_KEY/...
Режим: створити стилі і застосувати до файлу
```

---

### Full Variables

Будує variables-архітектуру у Figma за трирівневою структурою: primitive → semantic → component. Може створити з нуля, мігрувати зі styles або доповнити існуючу систему.

**Коли використовувати:**
- потрібно перейти від styles до variables
- є variables але структура незрозуміла або неповна
- треба підготувати файл до theming або multi-brand

**Що робить:**
- аналізує існуючі styles та variables
- пропонує трирівневу структуру колекцій: Primitives / Semantics / Components
- виявляє відсутні змінні та дублікати
- перевіряє правильність alias-ланцюжків
- застосовує variables до layout після підтвердження

**Структура variables, яку будує скіл:**

```
Primitives        →   Semantics              →   Components
color/gray/900    →   color/text/default     →   button/text/default
color/blue/500    →   color/fill/primary     →   button/background/default
spacing/4         →   spacing/component/gap  →   input/padding/default
```

**Як запустити:**

```
/full-variables

Figma: https://www.figma.com/design/FILE_KEY/...
```

або з уточненням:

```
/full-variables

Figma: https://www.figma.com/design/FILE_KEY/...
Задача: мігрувати styles у variables
```

```
/full-variables

Figma: https://www.figma.com/design/FILE_KEY/...
Задача: аудит — знайти пропущені variables
```

---

### Import Webpage to Figma

Відкриває живу вебсторінку у браузері та імпортує її як frame у Figma. Корисно для конкурентного аналізу, документування референсів або фіксації поточного стану продукту.

**Коли використовувати:**
- потрібно зафіксувати вебсторінку як референс у Figma
- хочеш задокументувати конкурентів або власний продукт
- потрібні конкретні стани інтерфейсу (відкрите меню, модалка, фільтри)

**Що робить:**
- відкриває сторінку у реальному браузері через Playwright
- чекає повного завантаження
- робить знімок при точному viewport-розмірі
- передає результат у вказаний Figma файл як frame

**Обмеження:**
- один viewport за один запит (desktop і mobile — два окремі запити)
- тільки повна сторінка, не окремі компоненти
- термінал зависне після capture — це нормально, натисни Ctrl+C

**Як запустити:**

```
/import-webpage-to-figma

Figma: https://www.figma.com/design/FILE_KEY/...
Site: https://example.com
Viewport: Desktop 1440
```

```
/import-webpage-to-figma

Figma: https://www.figma.com/design/FILE_KEY/...
Site: https://example.com
Viewport: Mobile 390
```

---

## Playwright MCP — автоматична активація

Скіл `import-webpage-to-figma` потребує Playwright MCP для керування браузером. У репозиторії вже є `.claude/settings.json` який вмикає його автоматично — нічого налаштовувати не потрібно.

**Як це працює:** Claude Code при старті читає `.claude/settings.json` у папці проєкту і підключає всі MCP сервери з `mcpServers`. Playwright запускається як локальний сервер і дає Claude інструменти для роботи з браузером.

Конфігурація діє лише в межах цього репозиторію і не змінює глобальні налаштування Claude Code на машині.

---

## Структура репозиторію

```
AI Design Processes/
├── .claude/
│   └── settings.json                       # Playwright MCP — вмикається автоматично
├── claude/
│   └── skills/
│       ├── style-system/                   # Extraction та нормалізація стилів
│       │   └── references/                 # Правила typography, color, audit
│       ├── full-variables/                 # Побудова variables-архітектури
│       │   └── references/                 # Token hierarchy, best practices
│       └── import-webpage-to-figma/        # Імпорт вебсторінок у Figma
├── install.sh                              # Скрипт встановлення
└── README.md
```
