#!/bin/bash
clear

echo "Actualizar los repositorios"
sudo apt update

echo "Actualizar los paquetes instalados"
sudo apt upgrade -y

echo "Solucionar fallos de actualización"
sudo apt --fix-broken install -y

echo "Eliminar paquetes no necesarios"
sudo apt autoremove -y

echo "Limpiar la caché de paquetes descargados"
sudo apt clean
