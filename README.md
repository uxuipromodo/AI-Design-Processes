# Design Skills for Figma

Skills — це інструкційні модулі для Claude Code, які дозволяють працювати з Figma системно: витягувати стилі, будувати variables-архітектуру та імпортувати вебсторінки як frames. Claude не робить нічого без твого підтвердження — спочатку показує план, ти погоджуєшся, тоді вносяться зміни.

---

## Встановлення

Потрібен Claude Code → [claude.ai/download](https://claude.ai/download)

Одна команда в терміналі:

```bash
git clone https://github.com/uxuipromodo/AI-Design-Processes.git /tmp/ai-skills && bash /tmp/ai-skills/install.sh
```

Скрипт автоматично:
- завантажить репозиторій в `~/.claude/ai-design-skills/`
- встановить всі skills в `~/.claude/skills/`
- налаштує автооновлення при кожному старті Claude Code

**Оновлення вручну:**

```bash
bash ~/.claude/sync-skills.sh
```

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
