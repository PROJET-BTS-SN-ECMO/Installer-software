#!/bin/bash

echo "/!\Le script dois etre lancer en mode root et pas simplement avec sudo\n"

echo "suppression de logiciel inutile"
apt remove firefox geany thonny vlc realvnc-vnc-viewer -y

echo "Activation ssh"
raspi-config nonint do_ssh 0 

echo "Activation VNC"
raspi-config nonint do_vnc 0

echo "Activation de SPI interface"
raspi-config nonint do_spi 0

echo "Activation de l'interface I2C"
raspi-config nonint do_i2c 0

echo "Activation de la laison Serie"
raspi-config nonint do_serial_hw 0 
raspi-config nonint do_serial_cons 0

echo "Activation de la connection wire"
raspi-config nonint do_onewire 0 

echo "Activation des gpio"
raspi-config nonint do_rgpio 0

echo "mise a jour du raspberry" 
apt update
apt upgrade -y

echo "installation de qt"
apt-get install qt6-base-dev -y

echo "installer de wiringPi"
wget https://github.com/WiringPi/WiringPi/releases/download/3.2/wiringpi_3.2_arm64.deb
apt-get install  ./wiringpi_3.2_arm64.deb -y 

echo "Wiring PI installer"
echo "Telechargement et installation du logiciel arduino"
apt install arduino -y

echo "Telechargement du logiciel a televersser"
wget https://github.com/PROJET-BTS-SN-ECMO/mainsoft-arduino/releases/download/1.00/mainsoft-arduino.zip
unzip mainsoft-arduino.zip -d /home/ecmo/mainsoft-arduino
chown -R ecmo:ecmo /home/ecmo/mainsoft-arduino
echo "Brancher l'arduino Nano et ouvree l'IDE Arduino "
echo "Et televersser le programme qui se trouve dans /home/ecmo/mainsoft-arduino"
read -p "Appuyer pour entrer pour continuer une fois que vous avez televerser le logiciel dans l'arduino"

echo "Telechargement du logiciel Principale"
wget https://github.com/PROJET-BTS-SN-ECMO/Creaplasm-soft/releases/download/1.00/Creaplasm-soft.zip
unzip Creaplasm-soft.zip -d /home/ecmo/mainSoft 
chmod +x /home/ecmo/mainSoft/Creaplasm-soft

echo "Telechargement de script d'arret par bouton du raspberry"
wget https://github.com/PROJET-BTS-SN-ECMO/shutdownPushButton/releases/download/1.00/shutdownPushButton.zip
unzip shutdownPushButton.zip -d /home/ecmo/developpement/
chmod +x /home/ecmo/developpement/shutdownPushButton/script.sh
cp /home/ecmo/developpement/shutdownPushButton/btnService.service /etc/systemd/system
systemctl enable btnService.service
echo "[Unit]\nDescription=Logiciel Creaplasm\n[Service]\nExecStart=/home/ecmo/mainSoft/Creaplasm-soft\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/softCrea.service
systemctl enable softCrea.service

read -p "Appuyer pour entrer pour redemarrer" 
reboot