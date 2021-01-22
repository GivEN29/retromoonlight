#!/bin/bash

echo -e "\nCreating Refresh script in Moonlight..."

if [ -d /home/pi/RetroPie/roms/moonlight ] 
then
    rm -rf /home/pi/RetroPie/roms/moonlight
fi

mkdir -p /home/pi/RetroPie/roms/moonlight

chmod a+x ./Scripts/Refresh.sh
/bin/cp ./Scripts/Refresh.sh /home/pi/RetroPie/roms/moonlight/Refresh.sh
/bin/cp ./GenerateGamesList.py /home/pi/RetroPie/roms/moonlight/GenerateGamesList.py
/bin/cp ./Scripts/Force_Quit.sh /home/pi/RetroPie/roms/moonlight/Force_Quit.sh

echo "Input your network broadcast ip address (e.g. 192.168.1.255):"
read $ip
echo "Input your pc's network card mac address:"
read $mac_addr

sed -i "s/IP/$ip/g; s/MAC_ADDR/$mac_addr/g" WakeOnLan.sh
chmod a+x ./Scripts/WakeOnLan.sh
/bin/cp ./Scripts/WakeOnLan.sh /home/pi/RetroPie/roms/moonlight/WakeOnLan.sh
echo -e "WakeOnLan script has been added to RetroPie\n"

chmod 777 /home/pi/RetroPie/roms/moonlight

echo -e "Refresh script has been added to RetroPie\n"
echo -e "After loading RetroPie, use the \"Refresh\" rom listed in the Moonlight system.\n"
