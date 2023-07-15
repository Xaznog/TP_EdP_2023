#!/bin/bash

# Se deberán recortar las imágenes a una resolución de 512*512 con alguna utilidad como imagemagick.
# Solamente deben procesarse aquellas imágenes que tengan nombres de personas válidos.
# Entiéndase por nombres de personas válidos a cualquier combinación de palabras que empiecen con un letra mayúscula y sigan por minúsculas.

# Creación de variables
RUTA_IMAGENES="/home/scripts/imagenes_descargadas"			# Ruta de las imágenes generadas
REG_EXP_VAL="^[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+(\s[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+)*\.(.+)?$"	# Expresión regular de nombres válidos

if [ -e $RUTA_IMAGENES ]	# VALIDACIÓN: Verificación de existencia de carpeta con imágenes descargadas
then
	# Asignación de permisos al directorio que contiene las imágenes descargadas y navegación al mismo
	chmod +rwx $RUTA_IMAGENES
	cd $RUTA_IMAGENES

	# Limpieza de archivos de ejecuciones anteriores
	if [ -e lista_nombres.txt ]
	then
		rm lista_nombres.txt
	fi

	ls | egrep $REG_EXP_VAL > lista_nombres.txt		# Crea un archivo con todos los nombres válidos
	CANT_NOMBRES=$(ls | egrep $REG_EXP_VAL | wc -l)	# Cuenta la cantidad de líneas (nombres válidos)

	if [ $CANT_NOMBRES -gt 0 ] 					# Si existe al menos un nombre válido...
	then
		for i in $(seq 1 $CANT_NOMBRES)			# Itera todas las líneas de la lista de nombres
		do
			NOMBRE=$(head -$i lista_nombres.txt | tail -1)	#Toma la línea $i de la lista de nombres
			if [[ -f $NOMBRE ]]					# VALIDACIÓN: Verifica que el archivo de la imágen exista y sea regular
			then
				if [[ -r $NOMBRE ]]				# VALIDACIÓN: Verifica que el archivo de la imágen tenga permisos de lectura
				then
					# Procesamiento de imagen
					echo "Procesando imagen $i de $CANT_NOMBRES..."
					convert "$NOMBRE" -gravity center -resize 512x512+0+0 -extent 512x512 ./"$NOMBRE"
				else
					echo -e "\e[31mERROR: El archivo $NOMBRE no tiene permisos de lectura.\e[0m"
					rm lista_nombres.txt
					exit 4
				fi
			else
				echo -e "\e[31mERROR: El archivo $NOMBRE no es archivo regular.\e[0m"
				rm lista_nombres.txt
				exit 3
			fi
		done
		echo -e "\e[32mFinalizado el procesado de imágenes.\e[0m"

		# Eliminación de archivo temporal
		rm lista_nombres.txt

		exit 0
	else
		echo -e "\e[31mERROR: No hay imagenes con nombres válidos.\e[0m"
		exit 2
	fi
else
	echo -e "\e[31mERROR: La carpeta con las imágenes no existe, realizar primero los pasos de GENERAR y DESCARGAR en ese orden.\e[0m"
	exit 1
fi
