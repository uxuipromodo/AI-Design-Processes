# Design Skills for Figma

Цей репозиторій містить набір skills для роботи з Figma через Claude Code та MCP workflows.

---

## Структура репозиторію

```
AI Design Processes/
├── .claude/
│   └── settings.json          # Project-level MCP конфігурація (Playwright)
├── claude/
│   └── skills/
│       ├── style-system/      # Extraction стилів із layout
│       ├── full-variables/    # Побудова variables-архітектури
│       └── import-webpage-to-figma/  # Імпорт вебсторінок у Figma
├── install.sh                 # Скрипт встановлення skills
└── README.md
```

---

## Встановлення

Одна команда в терміналі — більше нічого не потрібно:

```bash
git clone https://github.com/uxuipromodo/AI-Design-Processes.git /tmp/ai-skills && bash /tmp/ai-skills/install.sh
```

Скрипт автоматично:
- завантажить репозиторій в `~/.claude/ai-design-skills/`
- встановить всі скіли в `~/.claude/skills/`
- налаштує автооновлення при кожному старті Claude Code

**Потребує:** Claude Code на машині → [claude.ai/download](https://claude.ai/download)

**Оновлення вручну** (якщо не хочеш чекати наступного старту):

```bash
bash ~/.claude/sync-skills.sh
```

---

## Автоматична активація Playwright MCP

У репозиторії є файл `.claude/settings.json` — це project-level конфігурація Claude Code.

**Як це працює:**

Claude Code при кожному старті шукає `.claude/settings.json` у поточній директорії проєкту. Якщо знаходить — автоматично підключає всі MCP сервери, описані в `mcpServers`, без будь-яких дій з боку користувача.

Тобто достатньо склонувати цей репозиторій і відкрити його в Claude Code — Playwright MCP буде активний одразу.

```json
// .claude/settings.json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

Playwright MCP потрібен для скіла `import-webpage-to-figma` — він відкриває браузер, завантажує сторінку і передає знімок у Figma. Без нього скіл не працює.

**Що відбувається під капотом:**
1. Claude Code читає `.claude/settings.json` при старті сесії
2. Запускає `npx @playwright/mcp@latest` як локальний MCP сервер
3. Claude отримує інструменти керування браузером (`browser_navigate`, `browser_snapshot` тощо)
4. Скіл `import-webpage-to-figma` використовує ці інструменти для захоплення вебсторінки

Конфігурація діє лише в межах цього репозиторію і не змінює глобальні налаштування Claude Code на машині.

---

Skills описують структуровані підходи до:

- extraction стилів із layout
- побудови variables-систем
- імпорту існуючих інтерфейсів у Figma
- нормалізації дизайн-рішень

Вони використовуються як інструкційні модулі під час систематизації дизайн-файлів.


# Available Skills

| Skill | Призначення |
|------|-------------|
| Style System Skill | Extraction та нормалізація стилів |
| Full Variables Skill | Побудова variables-архітектури |
| Import Webpage to Figma | Імпорт вебсторінок у Figma |


## Style System Skill

Skill описує правила extraction стилів із layout та підготовки дизайн-файлу до побудови системи токенів.

Покриває:

- typography extraction
- color extraction
- spacing normalization
- radius normalization
- accessibility validation
- naming convention rules
- scale extension принципи
- audit principles

Використовується як підготовчий етап перед побудовою variables-архітектури.


## Full Variables Skill

Skill визначає архітектуру змінних у Figma та правила їх створення, використання і масштабування.

Variables будуються за трирівневою структурою:

primitive → semantic → component

Semantic variables описують зміст і призначення  
Component variables керують поведінкою компонентів

Skill включає:

- token hierarchy
- alias rules
- semantic naming logic
- accessibility roles
- duplicate detection
- missing variable detection
- migration зі styles у variables
- стабілізацію variables-системи

Використовується для побудови стабільної token-based дизайн-архітектури у Figma.


## Import Webpage to Figma

Skill використовується для імпорту живих вебсторінок у Figma з фіксацією конкретних viewport-розмірів та UI-станів.

Підтримує:

- desktop viewport capture
- mobile viewport capture
- capture interaction states (menu, modal, filters, dropdown)
- multi-frame імпорт за один запит
- передачу результату у вибраний Figma файл

Результатом роботи є набір frames, що відповідають реальному стану сторінки.
