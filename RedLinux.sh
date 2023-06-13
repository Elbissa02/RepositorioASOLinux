#!/bin/bash

clear

echo "------Interfaces de red detectadas------"
echo ""
ip link show
echo ""


echo "------Establecer dirección IP y mascara de red------"
echo ""
read -p "Introduzca la dirección IP: " direccionip
echo ""
read -p "Introduzca la mascara de red: " mascara
echo ""
read -p "Introduzca la interfaz: " interfaz
echo ""
sudo ip addr add $direccionip/$mascara dev $interfaz
echo ""


echo "------Establecer puerta de enlace------"
echo ""
read -p "Introduzca la puerta de enlace: " puertadeenlace
echo ""
sudo ip route add default via $puertadeenlace
echo ""


echo "------Establecer los servidores DNS------"
echo ""
read -p "Introduzca la direccion IP del servidor DNS: " servidordns
echo ""
sudo echo "nameserver $servidordns" >> /etc/resolv.conf
echo ""
