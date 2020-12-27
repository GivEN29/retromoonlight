#!/bin/bash
rpiversion=`head -1 /etc/apt/sources.list | cut -d " " -f3`

echo -e "\nAdding Moonlight to Sources List..."

if grep -q "deb http://archive.itimmer.nl/raspbian/moonlight $rpiversion main" /etc/apt/sources.list; then
    echo -e "NOTE: Moonlight Source Exists - Skipping"
else
    echo -e "Adding Moonlight to Sources List"
    echo "deb http://archive.itimmer.nl/raspbian/moonlight $rpiversion main" >> /etc/apt/sources.list
fi

echo -e "\nFetching and installing the GPG key....\n"

if [ -f /home/pi/itimmer.gpg ]
then	
    echo -e "NOTE: GPG Key Exists - Skipping"
else		
    wget http://archive.itimmer.nl/itimmer.gpg
    chown pi:pi /home/pi/itimmer.gpg
    apt-key add itimmer.gpg		
fi

echo -e "\nUpdating System..."
apt-get update -y

echo -e "\nInstalling dependencies..."
apt-get install git libopus0 libexpat1 libasound2 libudev1 libavahi-client3 libcurl4 libevdev2 libenet7 libssl-dev libopus-dev libasound2-dev libudev-dev libavahi-client-dev libcurl4-openssl-dev libevdev-dev libexpat1-dev libpulse-dev uuid-dev libenet-dev cmake gcc g++ fakeroot debhelper -y
apt-get install libraspberrypi-dev -y

echo -e "\nInstalling Moonlight..."
git clone https://github.com/irtimmer/moonlight-embedded.git
cd moonlight-embedded
git submodule update --init
mkdir build
cd build/
cmake ../
make
sudo make install
sudo ldconfig
cd ../..
echo -e "\nMoonlight Installed!"

echo -e "\nInstalling Gamepad..."
/bin/cat ./gamepad/steel-series-duo.txt >> /usr/share/moonlight/gamecontrollerdb.txt

