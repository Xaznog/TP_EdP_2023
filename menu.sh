#!/bin/bash

# Debe incluirse un menú para elegir cada una de las opciones anteriores.

# Inclusión de script con funciones
source /home/scripts/funciones.sh

# Creación de variables
RUTA_COMPRIMIDO="/home/scripts/imagenes_comprimidas.zip"	# Ruta donde se almacena el archivo comprimido con las imágenes
RUTA_CHECKSUM="/home/scripts/checksum_md5.txt"				# Ruta donde se almacena el checksum del archivo comprimido
RUTA_TRABAJO="/home/scripts"								# Ruta donde se trabajará

# Valida instalación del paquete ImageMagick
validar_instalacion "convert" "ImageMagick"

# Valida instalación del paquete ZIP
validar_instalacion "zip" "ZIP"

# Valida instalación del paquete WGET
validar_instalacion "wget" "WGET"

# Valida instalación del paquete ucommon-utils
validar_instalacion "md5sum" "ucommon-utils"




# Ejecución del menú de opciones
CTRL_EJECUCION=0
while :
do
	sleep 3
	clear
	echo -e "\e[36m               Bienvenido al TP de Entorno de Programación               \e[0m"
	echo -e "\e[36m   Grupo 1 - Integrantes: Germán Alanis, Gonzalo Asad, Sergio Castells   \e[0m"
	echo -e "\e[33m=========================================================================\e[0m"
	echo "Seleccione una opción:"
	if [ $CTRL_EJECUCION -eq 0 ]; then
		echo -e "1) \e[5;3mGenerar\e[0m"
	else
		echo "1) Generar"
	fi
	if [ $CTRL_EJECUCION -eq 1 ]; then
		echo -e "2) \e[5;3mDescomprimir\e[0m"
	else
		echo "2) Descomprimir"
	fi
	if [ $CTRL_EJECUCION -eq 2 ]; then
		echo -e "3) \e[5;3mProcesar\e[0m"
	else
		echo "3) Procesar"
	fi
	if [ $CTRL_EJECUCION -eq 3 ]; then
		echo -e "4) \e[5;3mComprimir\e[0m"
	else
		echo "4) Comprimir"
	fi
	if [ $CTRL_EJECUCION -eq 4 ]; then
		echo -e "5) \e[5;3mSalir\e[0m"
	else
		echo "5) Salir"
	fi
	echo -e "\e[33m=========================================================================\e[0m"

	read OPCION

	case $OPCION in
		1)	# Llamada al script generar.sh
			echo -n "Ingrese la cantidad de imágenes que desea generar: "
			read CANT_IMAGENES
			$RUTA_TRABAJO/generar.sh $CANT_IMAGENES

			if [ $? -eq 0 ]; then
				CTRL_EJECUCION=1
			fi
			;;
		2)	# Llamada al script descomprimir.sh
			$RUTA_TRABAJO/descomprimir.sh $RUTA_COMPRIMIDO $RUTA_CHECKSUM

			if [ $? -eq 0 ]; then
				CTRL_EJECUCION=2
			fi
			;;
		3)	# Llamada al script procesar.sh
			$RUTA_TRABAJO/procesar.sh

			if [ $? -eq 0 ]; then
				CTRL_EJECUCION=3
			fi
			;;
		4)	# Llamada al script comprimir.sh
			$RUTA_TRABAJO/comprimir.sh

			if [ $? -eq 0 ]; then
				CTRL_EJECUCION=4
			fi
			;;
		5)	# Salir del programa y contenedor
			clear
			break
			;;
		*)
			echo -e "\e[31mERROR: La opción ingresada es inválida. Inténtelo nuevamente.\e[0m"
			;;
	esac
done