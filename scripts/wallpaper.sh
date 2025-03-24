#!/bin/fish

# Changing wallpaper
hyprctl hyprpaper preload "$argv[1]" >/dev/null
hyprctl hyprpaper wallpaper eDP-1,"$argv[1]" >/dev/null
echo preload = "$argv[1]" > ~/.config/hypr/hyprpaper.conf
echo wallpaper = eDP-1,"$argv[1]" >> ~/.config/hypr/hyprpaper.conf
hyprctl hyprpaper unload unused >/dev/null

# Apply pywal
wal --backend wal -i "$argv[1]"

# Apply pywal to tmux
source ~/.cache/wal/colors.fish
sed -i '$ d' ~/.config/tmux/tmux.conf.local
set _tmp "tmux_conf_battery_bar_palette=\"#$fish_color_param,#$fish_color_param,#$fish_pager_color_background\"" 
set _tmp_lower (string lower $_tmp)
echo $_tmp_lower >> ~/.config/tmux/tmux.conf.local
tmux source-file ~/.config/tmux/tmux.conf

