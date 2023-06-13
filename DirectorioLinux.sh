#!/bin/bash
clear

if dpkg-query -l | grep -i slapd; then
	echo "El servicio LDAP esta instalado."
else
	echo "El servicio LDAP no esta instalado."
	read -p "Desea instalar el servicio LDAP?(s/n): " Srespuesta
	if [[ "$Srespuesta" == "s" || "$Srespuesta" == "S" ]]; then
		sudo apt-get update
		sudo apt-get install slapd

		sudo dpkg-reconfigure slapd
	else
		echo "No se realizará la instalación."
	fi
fi
