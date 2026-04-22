#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
SYNC_SCRIPT="$CLAUDE_DIR/sync-skills.sh"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  AI Design Skills — Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 1. Перевірка Claude Code
if ! command -v claude &>/dev/null; then
  echo -e "${RED}✗ Claude Code не знайдено.${NC}"
  echo "  Встанови його: https://claude.ai/download"
  exit 1
fi
echo -e "${GREEN}✓ Claude Code знайдено${NC}"

# 2. Створення директорій
mkdir -p "$SKILLS_DIR"
echo -e "${GREEN}✓ ~/.claude/skills/ готово${NC}"

# 3. Копіювання скілів
echo ""
echo "Встановлення скілів..."

for skill_src in "$REPO_DIR/claude/skills"/*/; do
  skill_name=$(basename "$skill_src")
  skill_dst="$SKILLS_DIR/$skill_name"
  mkdir -p "$skill_dst"
  rsync -a --delete "$skill_src" "$skill_dst/" 2>/dev/null || cp -r "$skill_src"* "$skill_dst/"
  echo -e "  ${GREEN}✓${NC} $skill_name"
done

# 4. Запис sync-скрипту
cat > "$SYNC_SCRIPT" <<SYNCEOF
#!/bin/bash
REPO="$REPO_DIR"
SKILLS_DIR="$SKILLS_DIR"

cd "\$REPO" && git pull --quiet 2>/dev/null || true

for skill_src in "\$REPO/claude/skills"/*/; do
  skill_name=\$(basename "\$skill_src")
  skill_dst="\$SKILLS_DIR/\$skill_name"
  mkdir -p "\$skill_dst"
  rsync -a --delete "\$skill_src" "\$skill_dst/" 2>/dev/null || cp -r "\$skill_src"* "\$skill_dst/"
done
SYNCEOF

chmod +x "$SYNC_SCRIPT"
echo ""
echo -e "${GREEN}✓ Sync-скрипт записано${NC}"

# 5. Додавання SessionStart хука в settings.json
if [ ! -f "$SETTINGS_FILE" ]; then
  echo '{}' > "$SETTINGS_FILE"
fi

# Перевірка чи вже є хук
if grep -q "sync-skills.sh" "$SETTINGS_FILE" 2>/dev/null; then
  echo -e "${GREEN}✓ SessionStart хук вже налаштовано${NC}"
else
  # Додаємо хук через node (він є у всіх Mac з Claude Code)
  node -e "
const fs = require('fs');
const path = '$SETTINGS_FILE';
const raw = fs.readFileSync(path, 'utf8');
const cfg = JSON.parse(raw);

if (!cfg.hooks) cfg.hooks = {};
if (!cfg.hooks.SessionStart) cfg.hooks.SessionStart = [];

const alreadySet = cfg.hooks.SessionStart.some(h =>
  h.hooks && h.hooks.some(c => c.command && c.command.includes('sync-skills.sh'))
);

if (!alreadySet) {
  cfg.hooks.SessionStart.push({
    hooks: [{
      type: 'command',
      command: 'bash $SYNC_SCRIPT'
    }]
  });
}

fs.writeFileSync(path, JSON.stringify(cfg, null, 2));
console.log('ok');
" && echo -e "${GREEN}✓ SessionStart хук додано${NC}" || {
    echo -e "${YELLOW}⚠ Не вдалося автоматично додати хук.${NC}"
    echo "  Додай вручну в ~/.claude/settings.json:"
    echo '  "hooks": { "SessionStart": [{ "hooks": [{ "type": "command", "command": "bash '"$SYNC_SCRIPT"'" }] }] }'
  }
fi

# 6. Результат
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}  Готово! Скіли встановлено.${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Встановлені скіли:"
for skill_src in "$REPO_DIR/claude/skills"/*/; do
  echo "  • $(basename "$skill_src")"
done
echo ""
echo "  Автооновлення: при кожному старті Claude Code"
echo "  скіли синхронізуються з репозиторієм."
echo ""
echo "  Щоб оновити вручну:"
echo "  bash $SYNC_SCRIPT"
echo ""
