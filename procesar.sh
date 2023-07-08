#!/bin/bash

# Se deberán recortar las imágenes a una resolución de 512*512 con alguna utilidad como imagemagick.
# Solamente deben procesarse aquellas imágenes que tengan nombres de personas.
# Entiéndase por nombres de personas a cualquier combinación de palabras que empiecen con mayúsculas y sigan por minúsculas.

RUTA_IMAGENES="/home/tuia/EdP/TP/imagenes_descargadas"
#REG_EXP_PERS="^[A-Z][a-z]+(\s[A-Z][a-z]+)?\.(.+)?$"
REG_EXP_PERS="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+(\s[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+)?\.(.+)?$"

chmod +rwx $RUTA_IMAGENES

if [ -e $RUTA_IMAGENES ]
then
	cd $RUTA_IMAGENES
	if [ -e nuevas_imagenes ]
	then
		rm -r nuevas_imagenes
	fi

	if [ -e lista_nombres.txt ]
	then
		rm lista_nombres.txt
	fi
	ls | egrep $REG_EXP_PERS > lista_nombres.txt		# Crea un archivo con todos los nombres de personas
	CANT_NOMBRES=$(ls | egrep $REG_EXP_PERS | wc -l)	# Cuenta la cantidad de líneas (nombres)
	if [ $CANT_NOMBRES -gt 0 ]
	then
		mkdir nuevas_imagenes
		chmod +rwx nuevas_imagenes
		for i in $(seq 1 $CANT_NOMBRES)			# Itera todas las líneas de la lista de nombres
		do
			NOMBRE=$(head -$i lista_nombres.txt | tail -1)	#Toma la línea $i de la lista de nombres
			if [[ -f $NOMBRE ]]
			then
				if [[ -r $NOMBRE ]]
				then
					echo "Procesando imagen $i de $CANT_NOMBRES..."
					convert "$NOMBRE" -gravity center -resize 512x512+0+0 -extent 512x512 ./nuevas_imagenes/"$NOMBRE"
				else
					echo "ERROR: El archivo $NOMBRE no tiene permisos de lectura."
					rm lista_nombres.txt
					exit 4
				fi
			else
				echo "ERROR: El archivo $NOMBRE no es archivo regular."
				rm lista_nombres.txt
				exit 3
			fi
		done
		echo "Finalizado el procesado de imágenes."
		rm lista_nombres.txt
		exit 0
	else
		echo "ERROR: No hay imagenes con nombres de personas."
		exit 1
	fi
else
	echo "ERROR: La carpeta con las imágenes no existe, realizar primero los pasos de GENERAR y DESCARGAR en ese orden."
	exit 1
fi
