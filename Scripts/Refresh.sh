#!/bin/bash
moonlight list | tail -n +3 > gameslist.txt
python3 ~/RetroPie/roms/moonlight/GenerateGamesList.py "./gameslist.txt"
cp ~/retromoonlight/Scripts/Force_Quit.sh .
chmod +x Force_Quit.sh
