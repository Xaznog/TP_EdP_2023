#!/bin/bash

# Script que contiene funciones de uso común en el resto de los scripts

# Función para validar instalación de paquetes
# Como primer argumento recibirá el nombre de una función del paquete y como segundo argumento recibirá al nombre del paquete
function validar_instalacion {
	EXISTE_PAQUETE=$(whereis $1)
	if [[ $EXISTE_PAQUETE == "$1:" ]]
	then
		echo -e "\e[31mERROR: El paquete $2 no está instalado. Se interrumpirá la ejecución del programa.\e[0m"
		sleep 5
		exit 1
	fi
}

# Función para eliminar archivos de ejecuciones anteriores
# Toma como único argumento el archivo a eliminar
function elimina_archivo {
	if [ -e $1 ]
	then
		if [ -d $1 ]
		then
			rm -r $1
		else
			rm $1
		fi
	fi
}