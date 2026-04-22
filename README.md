# Design Skills for Figma

Цей репозиторій містить набір skills для роботи з Figma через Claude Code та MCP workflows.

---

## Встановлення (для нових учасників)

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
