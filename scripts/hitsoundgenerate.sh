#!/bin/bash
originalAffPath=$(readlink -f "$1")
cp "$1" ~/Arcaea/autoHitSound/"$2".aff
cd ~/Arcaea/autoHitSound/
python3 ~/Arcaea/autoHitSound/auto_hit.py "$2".aff && python3 ~/Arcaea/autoHitSound/hitRecorder.py
cp ~/Arcaea/autoHitSound/rhythm.wav "${originalAffPath}"
