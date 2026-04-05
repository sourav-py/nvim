#!/usr/bin/env bash

set -e

echo "🚀 Starting Neovim setup..."

# -------------------------
# 1. Install dependencies
# -------------------------
echo "📦 Installing dependencies..."

sudo apt update
sudo apt install -y neovim git curl clangd npm xclip build-essential

# Install tree-sitter CLI
sudo npm install -g tree-sitter-cli

# -------------------------
# 2. Install vim-plug
# -------------------------
echo "🔌 Installing vim-plug..."

PLUG_PATH="$HOME/.local/share/nvim/site/autoload/plug.vim"

if [ ! -f "$PLUG_PATH" ]; then
  curl -fLo "$PLUG_PATH" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "✔ vim-plug already installed"
fi

# -------------------------
# 3. Backup existing config
# -------------------------
NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_CONFIG_DIR" ]; then
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  BACKUP_DIR="$HOME/.config/nvim.backup-$TIMESTAMP"

  echo "📦 Existing Neovim config found."
  echo "➡️ Backing up to: $BACKUP_DIR"

  mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
fi

# -------------------------
# 4. Setup fresh config
# -------------------------
echo "📁 Setting up Neovim config..."

mkdir -p ~/.config/nvim

echo "⬇️ Downloading init.vim from GitHub..."

curl -fLo ~/.config/nvim/init.vim \
  https://raw.githubusercontent.com/sourav-py/nvim/main/init.vim

# -------------------------
# 5. Install plugins
# -------------------------
echo "📥 Installing plugins..."

nvim --headless +PlugInstall +qall

# -------------------------
# 6. Treesitter sync
# -------------------------
echo "🌳 Updating Treesitter..."

nvim --headless "+TSUpdateSync" +qall

echo "✅ Setup complete!"
echo "👉 Run 'nvim' and you're ready 🚀"
