#!/bin/bash

# Descarga un archivo comprimido de imágenes.
# De debe poder indicar por argumento dos archivos (uno con las imágenes y otro con una suma de verificación).
# Si ocurrió algún error se debe informar al usuario de lo contrario se procede a descomprimir.

RUTA_TRABAJO="/home/tuia/EdP/TP"
#RUTA_COMPRIMIDO="/home/tuia/EdP/TP/imagenes_comprimidas.zip"
#RUTA_CHECKSUM="/home/tuia/EdP/TP/checksum_md5.txt"
ARCHIVO_COMPRIMIDO=$1
CHECKSUM=$2

cd $RUTA_TRABAJO

if [ -f $ARCHIVO_COMPRIMIDO ]
then
	if [ -f $CHECKSUM ]
	then
		if [ -r $ARCHIVO_COMPRIMIDO ]
		then
			if [ -r $CHECKSUM ]
			then
				echo "Verificando el checksum..."
				md5sum -c $CHECKSUM
				if [ $? -eq 0 ]
				then
					mkdir imagenes_descargadas
					chmod +rwx imagenes_descargadas
					echo "Descompriminendo imágenes..."
					unzip -d $RUTA_TRABAJO/imagenes_descargadas $ARCHIVO_COMPRIMIDO
					echo "Finalizada la descompresión de imágenes."
					rm $ARCHIVO_COMPRIMIDO
					rm $CHECKSUM
					exit 0
				else
					echo "ERROR: El archivo comprimido está corrupto."
					exit 5
				fi
			else
				echo "ERROR: El archivo checksum no tiene permisos de lectura."
				exit 4
			fi
		else
			echo "ERROR: El archivo comprimido con las imágenes no tiene permisos de lectura."
			exit 3
		fi
	else
		echo "ERROR: No existe el archivo con el checksum. Asegurarse de GENERAR primero."
		exit 2
	fi
else
	echo "ERROR: No existe el archivo comprimido con las imágenes. Asegurarse de GENERAR primero."
	exit 1
fi

