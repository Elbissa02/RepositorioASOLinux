#!/bin/bash
clear
read -p "Ingresa el nombre de usuario para la copia de seguridad: " nombre

if id $nombre >/dev/null 2>&1; then
	backup_dir="/home/$nombre"
	mkdir -p $backup_dir

	cp -r "/home/$nombre" $backup_dir
	echo "La copia de seguridad del directorio personal de $nombre se ha realizado con éxito en $backup_dir"
else
	echo "El usuario $nombre no existe"
fi
