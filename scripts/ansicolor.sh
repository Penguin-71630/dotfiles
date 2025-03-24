#!/bin/bash

for i in {0..255}; do
    printf "\x1b[38;5;%sm%3s " "$i" "$i"
    if (( (i + 1) % 16 == 0 )); then
        echo  # 每 16 個顏色換行
    fi
done

echo -e "\n"
