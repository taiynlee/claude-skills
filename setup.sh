#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}[✓]${NC} $1"; }
info() { echo -e "${YELLOW}[…]${NC} $1"; }
err()  { echo -e "${RED}[✗]${NC} $1"; exit 1; }

echo "=============================="
echo " Claude Code Environment Setup"
echo "=============================="
echo ""

# Node.js
if ! command -v node &>/dev/null; then
  err "Node.js not found. Install it first: https://nodejs.org"
fi
ok "Node.js $(node -v)"

# npm
if ! command -v npm &>/dev/null; then
  err "npm not found. Please install npm."
fi
ok "npm $(npm -v)"

# Claude Code CLI
info "Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code
ok "Claude Code installed: $(claude --version 2>/dev/null || echo 'ok')"

# Plugins
info "Installing superpowers (anthropics/claude-plugins-official)..."
claude plugins add anthropics/claude-plugins-official
ok "superpowers installed"

info "Installing awesome-claude-skills (ComposioHQ/awesome-claude-skills)..."
claude plugins add ComposioHQ/awesome-claude-skills
ok "awesome-claude-skills installed"

echo ""
echo "=============================="
ok "Setup complete! Run: claude"
echo "=============================="
