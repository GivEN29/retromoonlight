#!/bin/bash
moonlight list | tail -n +3 > gameslist.txt
python3 ~/RetroPie/roms/moonlight/GenerateGamesList.py "./gameslist.txt"
cp ~/retromoonlight/Scripts/force_quit.sh .
chmod +x force_quit.sh
