if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_user_paths $fish_user_paths ~/scripts/
set -U fish_user_paths $fish_user_paths ~/scripts/competitive_programming

set -x VISUAL vim
set -x EDITOR vim
set -Ux XDG_CONFIG_HOME ~/.config
set -Ux ADW_DISABLE_PORTAL 1
set -Ux WP ~/.config/hypr/wallpapers

omf theme bobthefish


# Useful alias
alias ls="lsd -l"
alias cls="clear && lsd -l"
alias lsdir="lsd -dl */"
alias clsdir="clear && lsd -dl */"
alias ipa="ip -c=always a"
alias ipr="ip -c=always r"
alias ccat='pygmentize -g -O linenos=1,style=rrt'
alias ptable='python -c "import sys,prettytable; print(prettytable.from_csv(sys.stdin))"'
alias whereami="echo $PWD"


# Fish shell follows terminal color
set -g fish_color_command blue
set -g fish_color_comment gray
set -g fish_color_error red
set -g fish_color_keyword green
set -g fish_color_quote yellow
set -g fish_color_search_match --background=purple --foreground=white
set -g fish_color_normal white
set -g fish_color_param purple


# Coloring texts in terminal
set -Ux COLOREND "\x1b[0m"

set -Ux BLACK "\x1b[30m"
set -Ux RED "\x1b[31m"
set -Ux GREEN "\x1b[32m"
set -Ux YELLOW "\x1b[33m"
set -Ux BLUE "\x1b[34m"
set -Ux PURPLE "\x1b[35m"
set -Ux CYAN "\x1b[36m"
set -Ux WHITE "\x1b[37m"
set -Ux GRAY "\x1b[90m"

set -Ux BG_BLACK "\x1b[40m"
set -Ux BG_RED "\x1b[41m"
set -Ux BG_GREEN "\x1b[42m"
set -Ux BG_YELLOW "\x1b[43m"
set -Ux BG_BLUE "\x1b[44m"
set -Ux BG_PURPLE "\x1b[45m"
set -Ux BG_CYAN "\x1b[46m"
set -Ux BG_WHITE "\x1b[47m"
set -Ux BG_GRAY "\x1b[240m"


# App Images


# Scripts
alias tmuxconfig="~/scripts/tmuxconfig.sh"
alias fishconfig="~/scripts/fishconfig.sh"
alias kittyconfig="~/scripts/kittyconfig.sh"
alias vimconfig="~/scripts/vimconfig.sh"
alias filemanager="~/scripts/filemanager.sh"
alias wallpaper="~/scripts/wallpaper.sh"
alias runcpp="~/scripts/runcpp.sh"
alias apktool="/usr/local/bin/apktool.sh"
alias extract="~/scripts/extract.sh"
alias imageEnhancer="/mnt/c/Users/Gino/OneDrive/桌面/ImageQualityEnhancer/realesrgan-ncnn-vulkan.exe"
alias hitsoundgenerate="~/scripts/hitsoundgenerate.sh"

alias cfparse="python3 ~/scripts/competitive_programming/cf_problem_parser.py"
alias runtest="~/scripts/competitive_programming/run_sample_test.sh"
alias cf="~/scripts/competitive_programming/cf.fish"
set -Ux cf ~/scripts/competitive_programming/cf.fish


# Directory
set -x WIN "/mnt/windows/Users/Gino/"




# Use tmux upon login
tmux 2>/dev/null
set -g TERM xterm-256color

# Mount Windows Filesystem
sudo mount /dev/nvme0n1p3 /mnt/windows 2>/dev/null


# Created by `pipx` on 2025-03-13 13:09:24
set PATH $PATH /home/gino/.local/bin
