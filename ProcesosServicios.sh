#!/bin/bash
clear

echo "------Todos los procesos y servicios------"
ps aux
echo ""

echo "------Información relevante de un proceso o servicio ------"
read -p "Introduzca el PID del proceso o servicio: " pid
echo ""
ps -p $pid -o ppid,ppid,user,%cpu,%mem,cmd
echo ""

echo "------Detener o iniciar proceso o servicio------"
read -p "Introduzca el nombre del proceso o servicio: " nombre
read -p "¿Detener o Iniciar el proceso o servicio deseado? (d/i/n): " opcion
echo ""
if [[ $opcion == "d" || $opcion == "D" ]]; then
	sudo systemctl stop $nombre
	echo "El proceso o servicio ha sido detenido"
elif [[ $opcion == "i" || $opcion == "I" ]]; then
	sudo systemctl start $nombre
	echo "El servicio o proceso ha sido iniciado"
else
	echo "No se aplicará ninguna de las dos opciones"
fi
