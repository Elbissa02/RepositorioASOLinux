#!/bin/bash
menu() {
	echo 1. "hardware"
	echo 2. "red"
	echo 3. "directorio"
    echo 4. "procesosSeguridad"
	echo 5. "backup"
	echo 6. "usuarios"
	echo 7. "actualizaciones"
	echo 8. "seguridad"

}


hardware(){

    echo "------Información relevante del procesador------"
    echo ""
    lscpu
    echo ""

    echo "------Información relevante de la memoria------"
    echo ""
    free
    echo""

    echo "------Información relevante del disco duro------"
    echo ""
    df
    echo ""
}



red(){

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
}



directorio(){

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

}



procesosServicios(){

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

}



backup(){

    read -p "Ingresa el nombre de usuario para la copia de seguridad: " nombre

    if id $nombre >/dev/null 2>&1; then
	    backup_dir="/home/$nombre"
	    mkdir -p $backup_dir

	    cp -r "/home/$nombre" $backup_dir
	    echo "La copia de seguridad del directorio personal de $nombre se ha realizado con éxito en $backup_dir"
    else
	    echo "El usuario $nombre no existe"
    fi
}



usuarios(){

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
}



actualizaciones(){

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

}



seguridad(){

    auth_log="/var/log/auth.log"

    fallos_inicio="Failed password"

    fallos_ubicaciones="Unauthorized Location"

    intento_inicio=$(grep "$fallos_inicio" "$auth_log")

    intento_ubicaciones=$(grep "$fallos_ubicaciones" "$auth_log")

    if [[ -n $intento_inicio ]]; then
	    echo "Se detectaron inicios de sesion incorrectas:"
	    echo "$intento_inicio"
    else
    	echo "No se encontraron inicios de sesion no atorizados."
    fi

    if [[ -n $intento_ubicaciones ]]; then
    	echo "Se detectaron intentos de incio de sesion desde ubicaciones no autorizadas:"
    	echo "$intento_ubicaciones"
    else
    	echo "No se encontraron inicio de sesion desde ubicaciones no autorizadas."
    fi
}



while true;do
	menu
	read -p "Seleccione una de las opciones del menú: " opcion
	case $opcion in
		1)clear;hardware;;
		2)clear;red;;
		3)clear;directorio;;
        4)clear;procesosServicios;;
        5)clear;backup;;
        6)clear;usuarios;;
        7)clear;actualizaciones;;
        8)clear;seguridad;;
		*)echo "No existe";break;;
	esac
done
