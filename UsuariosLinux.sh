#!/bin/bash
clear

read -p "Nombre de usuario: " nombre
read -p "Escriba la contraseña: " contraseña
read -p "Número de telefono: " movil
read -p "Escriba el correo electrónico: " correo

adduser $nombre

echo "$nombre:$contraseña" | chpasswd

usermod -c "$movil $correo" "$nombre"

echo "Usuario creado correctamente"
echo "Nombre de usuario: $nombre"
echo "Número de telefono: $movil"
echo "Correo electrónico: $correo"
