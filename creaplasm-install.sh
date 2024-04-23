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

echo "installation des dependence "
apt-get install qt6-base-dev arduino -y
echo "Installation de dependance effectuer"

echo "installer de wiringPi"
apt-get install ./wiringpi_3.2_arm64.deb -y 
echo "Wiring PI installer"

echo "Telechargement des composant logiciel"
wget https://github.com/WiringPi/WiringPi/releases/download/3.2/wiringpi_3.2_arm64.deb
wget https://github.com/PROJET-BTS-SN-ECMO/creaplasm-depot/releases/download/1.00/mainsoft-arduino.zip
wget https://github.com/PROJET-BTS-SN-ECMO/creaplasm-depot/releases/download/1.05/Creaplasm-soft.zip
wget https://github.com/PROJET-BTS-SN-ECMO/creaplasm-depot/releases/download/1.00/shutdownPushButton.zip
wget https://github.com/PROJET-BTS-SN-ECMO/creaplasm-depot/releases/download/1.00/softCrea.service
unzip mainsoft-arduino.zip -d /home/ecmo/mainsoft-arduino
unzip Creaplasm-soft.zip -d /home/ecmo/mainSoft
unzip shutdownPushButton.zip -d /home/ecmo/

echo "Ajout de droit sur les composant logiciel"
chown -R ecmo:ecmo /home/ecmo/mainsoft-arduino
chmod -R /home/ecmo/mainSoft/Creaplasm-soft
chmod -R /home/ecmo/shutdownPushButton/script.sh
chmod +x /home/ecmo/mainSoft/Creaplasm-soft
chmod +x /home/ecmo/shutdownPushButton/script.sh

echo "Ajout des deux services au demarage du systeme d'exploitation"
cp /home/ecmo/developpement/shutdownPushButton/btnService.service /etc/systemd/system
cp /root/softCrea.service /etc/systemd/system

echo "Brancher l'arduino Nano et ouvree l'IDE Arduino "
echo "Et televersser le programme qui se trouve dans /home/ecmo/mainsoft-arduino"
read -p "Appuyer pour entrer pour continuer une fois que vous avez televerser le logiciel dans l'arduino"

echo "Activation des service"
systemctl enable btnService.service
systemctl enable softCrea.service

echo "Composant logiciel installer redemarer pour utiliser le system"
read -p "Appuyer pour entrer pour redemarrer" 
reboot