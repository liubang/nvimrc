#!/usr/bin/env bash
set -euo pipefail

# format.sh — format all Lua files in the project using stylua
# stylua must be installed (e.g. via Mason: :MasonInstall stylua)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Locate stylua binary: prefer Mason install, fall back to PATH
STYLUA=""
MASON_STYLUA="$HOME/.local/share/nvim/mason/packages/stylua/stylua"

if [[ -x "$MASON_STYLUA" ]]; then
  STYLUA="$MASON_STYLUA"
elif command -v stylua &>/dev/null; then
  STYLUA="stylua"
else
  echo "error: stylua not found" >&2
  echo "Install it via Mason in Neovim: :MasonInstall stylua" >&2
  exit 1
fi

echo "Using stylua: $STYLUA ($("$STYLUA" --version))"
echo "Formatting all Lua files under: $SCRIPT_DIR"

# stylua reads stylua.toml from cwd automatically
"$STYLUA" .

echo "Done."
