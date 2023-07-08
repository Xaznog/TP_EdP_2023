#!/bin/bash

# Debe incluirse un menú para elegir cada una de las opciones anteriores.

RUTA_COMPRIMIDO="/home/tuia/EdP/TP/imagenes_comprimidas.zip"
RUTA_CHECKSUM="/home/tuia/EdP/TP/checksum_md5.txt"

echo "Bienvenido al TP de Entorno de Programación!"

while :
do
	echo "========================================================================================"
	echo "Seleccione una opción:"
	echo "1) Generar"
	echo "2) Descomprimir"
	echo "3) Procesar"
	echo "4) Comprimir"
	echo "5) Salir"

	read OPCION

	case $OPCION in
		1)
			echo -n "Ingrese la cantidad de imágenes que desea generar: "
			read CANT_IMAGENES
			./generar.sh $CANT_IMAGENES
			;;
		2)
			./descomprimir.sh $RUTA_COMPRIMIDO $RUTA_CHECKSUM
			;;
		3)
			./procesar.sh
			;;
		4)
			./comprimir.sh
			;;
		5)
			clear
			break
			;;
		*)
			echo "ERROR: La opción ingresada es inválida. Inténtelo nuevamente."
			;;
	esac
	if [ $? -ne 0 ]
	then
		echo "ERROR: Se ha producido un error."
	fi
done
