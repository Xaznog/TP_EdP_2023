#!/bin/bash

# Genera imágenes utilizando algún servicios web.
# Tener en cuenta que al descargar de una página conviene usar un sleep entre descarga y descarga para no saturar el servicio y evitar problemas.
# Se debe poder indicar por argumento cuantas imágenes generar y se deben asignar nombres de archivo al azar de una lista de nombres de personas.
# Luego se deben comprimir las imágenes, y generar un archivo con su suma de verificación.


ARCHIVO_NOMBRES="/home/tuia/EdP/TP/dataset.csv"
RUTA_IMAGENES="/home/tuia/EdP/TP/imagenes_descargadas"
RUTA_TRABAJO="/home/tuia/EdP/TP"
#URL_IMAGENES="https://source.unsplash.com/random/900%C3%97700/?person"
URL_IMAGENES="https://thispersondoesnotexist.com"

chmod +rwx $RUTA_TRABAJO
cd $RUTA_TRABAJO

if [ -e $RUTA_IMAGENES ]
then
	rm -r $RUTA_IMAGENES
fi

if [ -e nombres_usados.txt ]
then
	rm nombres_usados.txt
fi

if [ -e imagenes_comprimidas.zip ]
then
	rm imagenes_comprimidas.zip
fi

if [ -e checksum_md5.txt ]
then
	rm checksum_md5.txt
fi

if [ -e $ARCHIVO_NOMBRES ]
then
	if [ -r $ARCHIVO_NOMBRES ]
	then
		CANT_NOMBRES=$(cat $ARCHIVO_NOMBRES | wc -l)
		if [ $# -eq 1 ]
		then
			if [ $1 -le $CANT_NOMBRES ]
			then
				mkdir imagenes_descargadas
				chmod +rwx imagenes_descargadas
				touch nombres_usados.txt
				chmod +rwx nombres_usados.txt
				for i in $(seq 1 $1)
				do
					while :
					do
						# Verificamos que no hayamos creado ya un archivo con ese nombre
						NUM_RANDOM=$(($RANDOM%$CANT_NOMBRES))
						NOMBRE=$(head -$NUM_RANDOM $ARCHIVO_NOMBRES | tail -1 | cut -d ',' -f 1)	# El comando cut extrae porciones de texto, -d te permite elegir un delimitador, -f especifica el campo que querés extraer
						# NOMBRE=$(head -$NUM_RANDOM $ARCHIVO_NOMBRES | tail -1 | tr -d '\r')	# Toma la línea $NUM_RANDOM de la lista de nombres
						CANT_USO_NOMBRE=$(cat nombres_usados.txt | egrep "$NOMBRE" | wc -l)
						# Si el nombre no se usó aún, salimos del while
						if [ $CANT_USO_NOMBRE -eq 0 ]
						then
							break
						fi
					done
					# Agregamos nombre a la lista de nombres ya usados
					echo $NOMBRE >> nombres_usados.txt
					NOMBRE_IMAGEN="${RUTA_IMAGENES}/${NOMBRE}.jpeg"
					# Verificamos comunicación con la web
					if [ $i -eq 1 ]
					then
						echo "Comprobando conexión con el sitio $URL_IMAGENES..."
					fi
					for REINTENTOS_CONEXION in {1..3}
					do
						wget --spider -q $URL_IMAGENES
						if [ $? -eq 0 ]
						then
							for REINTENTOS_DESCARGA in {1..3}
							do
								echo "Generando imagen $i de $1, intento $REINTENTOS_DESCARGA de 3."
								wget -q -O "$NOMBRE_IMAGEN" $URL_IMAGENES
								sleep 2
								if [ $? -eq 0 ]
								then
									break 2
								fi
							done
						fi
						sleep 1
					done
					if [ -e "$NOMBRE_IMAGEN" ]
					then
						continue
					else
						echo "ERROR: Hubo problemas en la generación de imágenes, se aborta la operación."
						echo "Compruebe la conexión a internet y vuelva a intentarlo."
						rm -r $RUTA_IMAGENES
						rm nombres_usados.txt
						exit 5
					fi
				done
				echo "Se han generado las siguientes imágenes:"
				ls $RUTA_IMAGENES
				rm nombres_usados.txt
				cd $RUTA_IMAGENES
				echo "Comprimiendo imágenes..."
				zip -r $RUTA_TRABAJO/imagenes_comprimidas.zip ./
				md5sum $RUTA_TRABAJO/imagenes_comprimidas.zip > $RUTA_TRABAJO/checksum_md5.txt
				rm -r $RUTA_IMAGENES
				echo "Generado con éxito el archivo comprimido con las imágenes."
				exit 0
			else
				echo "ERROR: Argumento incorrecto. Se debe ingresar un número entero comprendido entre 1 y ${CANT_NOMBRES}."
				exit 4
			fi
		else
			echo "ERROR: Ha ingresado $# argumentos, debe ingresar tan sólo un argumento (cantidad de imágenes a generar)."
			exit 3
		fi
	else
		echo "ERROR: El archivo con lista de nombres no tiene permisos de lectura."
		exit 2
	fi
else
	echo "ERROR: No se encuentra el archivo con la lista de nombres."
	exit 1
fi
