#!/bin/bash

# Debe incluirse un menú para elegir cada una de las opciones anteriores.

RUTA_COMPRIMIDO="/home/scripts/imagenes_comprimidas.zip"
RUTA_CHECKSUM="/home/scripts/checksum_md5.txt"
RUTA_TRABAJO="/home/scripts"

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
			$RUTA_TRABAJO/generar.sh $CANT_IMAGENES
			;;
		2)
			$RUTA_TRABAJO/descomprimir.sh $RUTA_COMPRIMIDO $RUTA_CHECKSUM
			;;
		3)
			$RUTA_TRABAJO/procesar.sh
			;;
		4)
			$RUTA_TRABAJO/comprimir.sh
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
