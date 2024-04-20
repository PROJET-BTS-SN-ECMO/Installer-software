#!/bin/bash

echo "/!\Le script dois etre lancer en mode root et pas simplement avec sudo\n"

echo "suppression de logiciel inutile"
apt remove firefox geany thonny vlc realvnc-viewer -y

echo "mise a jour du raspberry" 

apt update
apt upgrade -y

echo "installer de wiringPi"
wget https://github.com/WiringPi/WiringPi/releases/download/3.2/wiringpi_3.2_arm64.deb
apt install  wiringpi_3.2_arm64.deb -y 

echo "Wiring PI installer"
echo "Telechargement et installation du logiciel arduino"
apt install arduino -y

apt "Telechargement du logiciel a televersser"
wget https://github.com/PROJET-BTS-SN-ECMO/mainsoft-arduino/releases/download/1.00/mainsoft-arduino.zip
unzip mainsoft-arduino.zip /home/ecmo/mainsoft-arduino
chown -R ecmo:ecmo /home/ecmo/mainsoft-arduino
echo "Brancher l'arduino Nano et ouvree l'IDE Arduino "
echo "Et televersser le programme qui se trouve dans /home/ecmo/mainsoft-arduino"
read -p "Appuyer pour entrer pour continuer une fois que vous avez televerser le logiciel dans l'arduino"

echo "Telechargement du logiciel Principale"
wget https://github.com/PROJET-BTS-SN-ECMO/Creaplasm-soft/releases/download/1.00/Creaplasm-soft.zip
unzip Creaplasm-soft.zip /home/ecmo/maiSoft 
