#!/bin/bash
moonlight list | tail -n +3 > gameslist.txt
python3 ~/RetroPie/roms/moonlight/GenerateGamesList.py "./gameslist.txt"
