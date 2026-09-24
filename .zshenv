# Environment and PATH. Read by every zsh: terminals, scripts, `zsh -c`, ssh commands.
# ~/.zshrc sources this again, because macOS's /etc/zprofile (path_helper) reorders
# PATH for login shells after this file runs.

# Keep PATH/fpath/INFOPATH free of duplicates
typeset -U PATH path FPATH fpath
typeset -TUx INFOPATH infopath

# Homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
path=($HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $path)
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
infopath=($HOMEBREW_PREFIX/share/info $infopath)

# Python 3.14
export PATH="/Library/Frameworks/Python.framework/Versions/3.14/bin:$PATH"

# Docker Desktop
export PATH="$PATH:$HOME/.docker/bin"

# JetBrains Toolbox
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# Spicetify
export PATH="$PATH:$HOME/.spicetify"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOMEBREW_PREFIX/opt/rustup/bin"

# Antigravity IDE
export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"
export GSETTINGS_SCHEMA_DIR="$HOMEBREW_PREFIX/share/glib-2.0/schemas"

# Railway
export RAILWAY_HOME="$HOME/.railway"
export PATH="$RAILWAY_HOME/bin:$PATH"

# Local binaries (uv, jcode, Antigravity CLI)
export PATH="$HOME/.local/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Node (fnm): interactive shells run `fnm env` in ~/.zshrc; everything else gets the default version
[[ -o interactive ]] || export PATH="$HOME/.local/share/fnm/aliases/default/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Java
export PATH="$HOMEBREW_PREFIX/opt/openjdk@21/bin:$PATH"

# Resend CLI
export PATH="$HOME/.resend/bin:$PATH"

# Android platform tools
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

# Google Cloud SDK
export PATH="$HOME/google-cloud-sdk/bin:$PATH"

# Google Calendar MCP credentials
export GOOGLE_OAUTH_CREDENTIALS="$HOME/.config/gcal-mcp/gcp-oauth.keys.json"

# Unity CLI
export PATH="$HOME/.unity/bin:$PATH"
