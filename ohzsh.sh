#!/bin/bash

# One-Click Oh My Zsh Setup for Debian/Ubuntu/macOS Node.js Development
# This script installs Zsh, Oh My Zsh, useful plugins, and configures everything for Node.js development

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Banner function with ASCII art
show_banner() {
    echo -e "${CYAN}"
    echo "╔═════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                             ║"
    echo "║    ██████╗ ██╗  ██╗ ██████╗ ██╗  ██╗███████╗███████╗██╗  ██╗                ║"
    echo "║   ██╔═████╗╚██╗██╔╝██╔═══██╗██║  ██║╚══███╔╝██╔════╝██║  ██║                ║"
    echo "║   ██║██╔██║ ╚███╔╝ ██║   ██║███████║  ███╔╝ ███████╗███████║                ║"
    echo "║   ████╔╝██║ ██╔██╗ ██║   ██║██╔══██║ ███╔╝  ╚════██║██╔══██║                ║"
    echo "║   ╚██████╔╝██╔╝ ██╗╚██████╔╝██║  ██║███████╗███████║██║  ██║                ║"
    echo "║    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝                ║"
    echo "║                                                                             ║"
    echo -e "║                    ${MAGENTA}🚀 One-Click Terminal Transformation 🚀${CYAN}                  ║"
    echo "║                                                                             ║"
    echo -e "║                     ${YELLOW}Follow us: https://x.com/0xohzsh${CYAN}                        ║"
    echo "║                                                                             ║"
    echo "║              Transform your terminal into a powerful dev environment        ║"
    echo "║                   with Oh My Zsh + Node.js + Beautiful Themes               ║"
    echo "║                                                                             ║"
    echo "╚═════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/debian_version ]] || command -v apt &> /dev/null; then
        echo "debian"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

# Clear screen for clean output
clear

# Show the banner
show_banner

# Check if running on supported system
if [[ "$OS" == "unknown" ]]; then
    print_error "This script supports Debian/Ubuntu and macOS systems only"
    exit 1
fi

print_header "Oh My Zsh + Node.js Development Setup ($OS)"

# Install packages based on OS
install_packages() {
    if [[ "$OS" == "macos" ]]; then
        # macOS installation
        print_status "Checking for Homebrew..."
        if ! command -v brew &> /dev/null; then
            print_status "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add Homebrew to PATH for Apple Silicon Macs
            if [[ -f /opt/homebrew/bin/brew ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
        fi

        print_status "Installing required packages via Homebrew..."
        brew update
        brew install \
            zsh \
            git \
            curl \
            wget \
            font-meslo-lg-nerd-font

    else
        # Debian/Ubuntu installation
        print_status "Updating package list..."
        sudo apt update

        print_status "Installing required packages via apt..."
        sudo apt install -y \
            zsh \
            git \
            curl \
            wget \
            build-essential \
            fonts-powerline \
            fonts-font-awesome \
            unzip
    fi
}

# Install packages
install_packages

# Install Oh My Zsh
print_status "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_warning "Oh My Zsh already installed, skipping..."
fi

# Set ZSH_CUSTOM directory
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Install useful plugins for Node.js development
print_status "Installing useful plugins..."

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# zsh-history-substring-search
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
fi

# you-should-use (reminds you to use aliases)
if [ ! -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use"
fi

# Install Powerlevel10k theme
print_status "Installing Powerlevel10k theme..."
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Install NVM (Node Version Manager)
print_status "Installing NVM (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Install latest LTS Node.js
print_status "Installing latest LTS Node.js..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if command -v nvm &> /dev/null; then
    nvm install --lts
    nvm use --lts
    nvm alias default lts/*
fi

# Install Yarn package manager
print_status "Installing Yarn package manager..."
if ! command -v yarn &> /dev/null; then
    if [[ "$OS" == "macos" ]]; then
        brew install yarn
    else
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt update && sudo apt install -y yarn
    fi
fi

# Configure .zshrc
print_status "Configuring .zshrc..."

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Create new .zshrc configuration
cat > "$HOME/.zshrc" << 'EOF'
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins for Node.js development
plugins=(
    git
    node
    npm
    yarn
    nvm
    docker
    docker-compose
    vscode
    extract
    colored-man-pages
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    you-should-use
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add npm global packages to PATH (for macOS permission fix)
export PATH="$HOME/.npm-global/bin:$PATH"

# Auto-load .nvmrc files
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Useful aliases for Node.js development
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Node.js specific aliases
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nis='npm install --save'
alias nls='npm list'
alias nod='npm outdated'
alias nrm='npm remove'
alias nrun='npm run'
alias nst='npm start'
alias nt='npm test'

# Yarn aliases
alias ya='yarn add'
alias yad='yarn add --dev'
alias yag='yarn global add'
alias yrm='yarn remove'
alias yrun='yarn run'
alias yst='yarn start'
alias yt='yarn test'
alias yup='yarn upgrade'

# Git aliases (additional to oh-my-zsh git plugin)
alias glog='git log --oneline --graph --decorate'
alias gst='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gl='git pull'

# Docker aliases
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'

# History configuration
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Key bindings for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# Install MesloLGS NF font for Powerlevel10k
print_status "Installing MesloLGS NF font for Powerlevel10k..."

if [[ "$OS" == "macos" ]]; then
    print_status "Font already installed via Homebrew (font-meslo-lg-nerd-font)"
else
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts

    # Download MesloLGS NF fonts
    fonts=(
        "MesloLGS%20NF%20Regular.ttf"
        "MesloLGS%20NF%20Bold.ttf"
        "MesloLGS%20NF%20Italic.ttf"
        "MesloLGS%20NF%20Bold%20Italic.ttf"
    )

    for font in "${fonts[@]}"; do
        if [ ! -f "${font//%20/ }" ]; then
            wget "https://github.com/romkatv/powerlevel10k-media/raw/master/${font}"
        fi
    done

    # Refresh font cache
    fc-cache -f -v
fi

# Install some useful global npm packages
print_status "Installing useful global npm packages..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if command -v npm &> /dev/null; then
    # Clear npm cache to avoid permission issues
    print_status "Clearing npm cache..."
    npm cache clean --force 2>/dev/null || true

    # Fix npm permissions on macOS
    if [[ "$OS" == "macos" ]]; then
        print_status "Fixing npm permissions..."
        mkdir -p ~/.npm-global
        npm config set prefix '~/.npm-global'
        export PATH=~/.npm-global/bin:$PATH
    fi

    # Install packages one by one to handle errors gracefully
    packages=(
        "pm2"
        "http-server"
        "typescript"
        "prettier"
    )

    for package in "${packages[@]}"; do
        print_status "Installing $package..."
        npm install -g "$package" 2>/dev/null || print_warning "Failed to install $package, skipping..."
    done
fi

# Create a basic Powerlevel10k configuration
print_status "Setting up Powerlevel10k configuration..."
cat > "$HOME/.p10k.zsh" << 'EOF'
# Generated by Powerlevel10k configuration wizard.
# Based on romkatv/powerlevel10k configuration.

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options. This allows you to apply configuration changes without
  # restarting zsh. Edit ~/.p10k.zsh and type `source ~/.p10k.zsh`.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  autoload -Uz is-at-least && is-at-least 5.1 || return

  # The list of segments shown on the left. Fill it with the most important segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon                 # os identifier
    dir                     # current directory
    vcs                     # git status
    prompt_char             # prompt symbol
  )

  # The list of segments shown on the right. Fill it with less important segments.
  # Right prompt on the last prompt line (where you are typing your commands) gets
  # automatically hidden when the input line reaches it. Right prompt above the
  # last prompt line gets hidden if it would overlap with left prompt.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    anaconda                # conda environment (https://conda.io/)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    goenv                   # go environment (https://github.com/syndbg/goenv)
    nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
    nvm                     # node.js version from nvm (https://github.com/creationix/nvm)
    nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
    node_version            # node.js version
    context                 # user@hostname
    time                    # current time
  )

  # Defines character set used by powerlevel10k. It's best to let `p10k configure` set it for you.
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  # Original powerline glyphs; the least safe choice. You'll need to install a Powerline font.
  # typeset -g POWERLEVEL9K_MODE=powerline

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  # Config wizard will overwrite this file.

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  #               typed after changing current working directory.
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

  # Instant prompt mode.
  #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
  #              it incompatible with your zsh configuration files.
  #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
  #              during zsh initialization. Choose this if you've read and understood
  #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #   - verbose: Enable instant prompt and print a warning when detecting console output during
  #              zsh initialization. Choose this if you've never tried instant prompt, live
  #              dangerously, and do not care about the performance implications of instant prompt.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
EOF

# Set Zsh as default shell
print_status "Setting Zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    if [[ "$OS" == "macos" ]]; then
        # macOS may require adding zsh to /etc/shells first
        if ! grep -q "$(which zsh)" /etc/shells; then
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
    fi
    chsh -s $(which zsh)
    print_warning "Shell changed to Zsh"
fi

# Create useful development directories
print_status "Creating development directories..."
mkdir -p ~/Projects
mkdir -p ~/Scripts

print_header "Installation Complete!"
print_status "Oh My Zsh has been installed with the following features:"
echo "  ✓ Powerlevel10k theme with auto-configuration"
echo "  ✓ Useful plugins for Node.js development"
echo "  ✓ NVM (Node Version Manager)"
echo "  ✓ Latest LTS Node.js"
echo "  ✓ Yarn package manager"
echo "  ✓ Useful aliases and configurations"
echo "  ✓ MesloLGS NF font for better terminal display"
echo "  ✓ Global npm packages for development"
echo ""
print_warning "Starting Zsh with new configuration..."

# Switch to zsh and source the configuration
exec zsh -c "source ~/.zshrc; echo '🎉 Setup complete! You are now using Zsh with Oh My Zsh!'; echo 'Run \"p10k configure\" anytime to customize your prompt further.'; zsh"