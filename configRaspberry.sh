echo "/!\Le script dois etre lancer en mode root et pas simplement avec sudo"
echo "Script de configation du raspberry"

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

read -p "Appuyer pour entrer pour redemarrer" 
reboot