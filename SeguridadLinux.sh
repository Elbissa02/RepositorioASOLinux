#!/bin/bash
clear

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
