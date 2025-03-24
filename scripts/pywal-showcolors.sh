source $HOME/.cache/wal/colors.sh

for i in {0..15}; do
    eval color=\$color$i
    printf "\e[48;5;${color}m ${color} \e[0m"
done
echo
