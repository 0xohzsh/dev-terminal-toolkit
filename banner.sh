#!/bin/bash

# 0xohzsh Banner - Reusable for all scripts
# Source this file in your scripts: source banner.sh

# Colors for banner
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Banner function with ASCII art
show_banner() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                              ║"
    echo "║    ██████╗ ██╗  ██╗ ██████╗ ██╗  ██╗███████╗███████╗██╗  ██╗                ║"
    echo "║   ██╔═████╗╚██╗██╔╝██╔═══██╗██║  ██║╚══███╔╝██╔════╝██║  ██║                ║"
    echo "║   ██║██╔██║ ╚███╔╝ ██║   ██║███████║  ███╔╝ ███████╗███████║                ║"
    echo "║   ████╔╝██║ ██╔██╗ ██║   ██║██╔══██║ ███╔╝  ╚════██║██╔══██║                ║"
    echo "║   ╚██████╔╝██╔╝ ██╗╚██████╔╝██║  ██║███████╗███████║██║  ██║                ║"
    echo "║    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝                ║"
    echo "║                                                                              ║"
    echo -e "║                    ${MAGENTA}🚀 One-Click Terminal Transformation 🚀${CYAN}                   ║"
    echo "║                                                                              ║"
    echo -e "║                     ${YELLOW}Follow us: https://x.com/0xohzsh${CYAN}                      ║"
    echo "║                                                                              ║"
    echo "║              Transform your terminal into a powerful dev environment        ║"
    echo "║                   with Oh My Zsh + Node.js + Beautiful Themes              ║"
    echo "║                                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# Minimal banner for compact use
show_mini_banner() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                    ${MAGENTA}0xohzsh${NC} ${YELLOW}• https://x.com/0xohzsh${NC}                    ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Usage examples:
# show_banner      # Full banner
# show_mini_banner # Compact banner