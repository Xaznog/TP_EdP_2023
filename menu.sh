#!/bin/bash

# Debe incluirse un menú para elegir cada una de las opciones anteriores.

# Función para validar instalación de paquetes
# Como primer argumento recibirá el nombre de una función del paquete y como segundo argumento recibirá al nombre del paquete
function validar_instalacion {
	EXISTE_PAQUETE=$(whereis $1)
	if [[ $EXISTE_PAQUETE == "$1:" ]]
	then
		echo "ERROR: El paquete $2 no está instalado. Se interrumpirá la ejecución del programa."
		sleep 5
		exit 1
	fi
}

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

echo -e "\e[35mBienvenido al TP de Entorno de Programación!\e[0m"
echo -e "\e[35mGrupo 1 - Integrantes: Germán Alanis, Gonzalo Asad y Sergio Castells\e[0m"

# Ejecución del menú de opciones
while :
do
	echo -e "\e[33m========================================================================================\e[0m"
	echo -e "\e[36mSeleccione una opción:\e[0m"
	echo -e "\e[36m1) Generar\e[0m"
	echo -e "\e[36m2) Descomprimir\e[0m"
	echo -e "\e[36m3) Procesar\e[0m"
	echo -e "\e[36m4) Comprimir\e[0m"
	echo -e "\e[36m5) Salir\e[0m"
	echo -e "\e[33m========================================================================================\e[0m"

	read OPCION

	case $OPCION in
		1)	# Llamada al script generar.sh
			echo -n "Ingrese la cantidad de imágenes que desea generar: "
			read CANT_IMAGENES
			$RUTA_TRABAJO/generar.sh $CANT_IMAGENES
			;;
		2)	# Llamada al script descomprimir.sh
			$RUTA_TRABAJO/descomprimir.sh $RUTA_COMPRIMIDO $RUTA_CHECKSUM
			;;
		3)	# Llamada al script procesar.sh
			$RUTA_TRABAJO/procesar.sh
			;;
		4)	# Llamada al script comprimir.sh
			$RUTA_TRABAJO/comprimir.sh
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