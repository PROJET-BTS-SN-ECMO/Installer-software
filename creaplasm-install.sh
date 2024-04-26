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
apt-get install qt6-base-dev -y
echo "Installation de dependance effectuer"

mkdir /soft

echo "Telechargement des composant logiciel"
wget https://github.com/WiringPi/WiringPi/releases/download/3.2/wiringpi_3.2_arm64.deb
wget https://github.com/PROJET-BTS-SN-ECMO/creaplasm-depot/releases/download/1.06/Creaplasm-soft.zip
wget https://github.com/PROJET-BTS-SN-ECMO/creaplasm-depot/releases/download/1.05/myapp.desktop
unzip Creaplasm-soft.zip -d /soft

echo "installer de wiringPi"
apt-get install ./wiringpi_3.2_arm64.deb -y 
echo "Wiring PI installer"

echo "Ajout de droit sur les composant logiciel"
mkdir /home/ecmo/.config/autostart
cp myapp.desktop /home/ecmo/.config/autostart
chown -R ecmo:ecmo /home/ecmo/.config/autostart
chmod +x /soft/Creaplasm-soft/CreaplasmSoft

echo "Composant logiciel installer redemarer pour utiliser le system"
read -p "Appuyer pour entrer pour redemarrer" 
apt autoremove -y
reboot