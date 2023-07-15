#!/bin/bash

# Se debe poder indicar por argumento dos archivos (uno con las imágenes comprimidas y otro con una suma de verificación).
# Si ocurrió algún error se debe informar al usuario de lo contrario se procede a descomprimir.

# Creación de variables
RUTA_TRABAJO="/home/scripts/"		# Ruta de trabajo
ARCHIVO_COMPRIMIDO=$1				# Ruta de archivo comprimido con las imágenes generadas
CHECKSUM=$2							# Ruta del checksum del archivo comprimido con las imágenes generadas

# Navegación a ruta de trabajo
cd $RUTA_TRABAJO

if [ -f $ARCHIVO_COMPRIMIDO ]		# VALIDACIÓN: Verifica existencia y tipo del archivo comprimido
then
	if [ -f $CHECKSUM ]				# VALIDACIÓN: Verifica existencia y tipo del checksum
	then
		if [ -r $ARCHIVO_COMPRIMIDO ]	# VALIDACIÓN: Verifica permisos de lectura del archivo comprimido
		then
			if [ -r $CHECKSUM ]			# VALIDACIÓN: Verifica permisos de lectura del checksum
			then
				# Verificación de checksum
				echo "Verificando el checksum..."
				md5sum -c $CHECKSUM
				# -c sirve para verificar el checksum

				if [ $? -eq 0 ]			# VALIDACIÓN: Si la salida del comando anterior da 0, significa que no hubo errores en la verificación de checksum
				then
					# Creación de carpeta que contendrá las imágenes descomprimidas y aisgnación de permisos a la misma
					mkdir imagenes_descargadas
					chmod +rwx imagenes_descargadas

					# Descompresión de imágenes
					echo "Descompriminendo imágenes..."
					unzip -d $RUTA_TRABAJO/imagenes_descargadas $ARCHIVO_COMPRIMIDO
					# -d especifica el directorio destino a donde se extraerán los archivos
					echo -e "\e[32mFinalizada la descompresión de imágenes.\e[0m"

					# Eliminación del archivo comprimido y del checksum. En este punto ya no son necesarios
					rm $ARCHIVO_COMPRIMIDO
					rm $CHECKSUM

					exit 0
				else
					echo -e "\e[31mERROR: El archivo comprimido está corrupto.\e[0m"
					exit 5
				fi
			else
				echo -e "\e[31mERROR: El archivo checksum no tiene permisos de lectura.\e[0m"
				exit 4
			fi
		else
			echo -e "\e[31mERROR: El archivo comprimido con las imágenes no tiene permisos de lectura.\e[0m"
			exit 3
		fi
	else
		echo -e "\e[31mERROR: No existe el archivo con el checksum. Asegurarse de GENERAR primero.\e[0m"
		exit 2
	fi
else
	echo -e "\e[31mERROR: No existe el archivo comprimido con las imágenes. Asegurarse de GENERAR primero.\e[0m"
	exit 1
fi

