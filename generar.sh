#!/bin/bash

# Genera imágenes utilizando algún servicios web.
# Tener en cuenta que al descargar de una página conviene usar un sleep entre descarga y descarga para no saturar el servicio y evitar problemas.
# Se debe poder indicar por argumento cuantas imágenes generar y se deben asignar nombres de archivo al azar de una lista de nombres de personas.
# Luego se deben comprimir las imágenes, y generar un archivo con su suma de verificación.

# Inclusión de script con funciones
source /home/scripts/funciones.sh

# Creación de variables
ARCHIVO_NOMBRES="/home/scripts/dataset.csv"				# Ruta del dataset
RUTA_IMAGENES="/home/scripts/imagenes_descargadas"		# Ruta de la carpeta con las imágenes generadas
RUTA_TRABAJO="/home/scripts/"							# Ruta de trabajo
#URL_IMAGENES="https://source.unsplash.com/random/900%C3%97700/?person"		# Vieja URL de generación de imágenes
URL_IMAGENES="https://thispersondoesnotexist.com"		# URL de generación de imágenes

# Asignación de permisos a la ruta de trabajo y navegación hacia ella
chmod +rwx $RUTA_TRABAJO
cd $RUTA_TRABAJO

# Limpieza de archivos de ejecuciones anteriores
elimina_archivo $RUTA_IMAGENES
elimina_archivo nombres_usados.txt
elimina_archivo imagenes_comprimidas.zip
elimina_archivo checksum_md5.txt

if [ -e $ARCHIVO_NOMBRES ]		# VALIDACIÓN: Verifica existencia de dataset
then
	if [ -r $ARCHIVO_NOMBRES ]	# VALIDACIÓN: Verifica permisos de lectura de dataset
	then
		CANT_NOMBRES=$(cat $ARCHIVO_NOMBRES | wc -l)	# Conteo de filas del dataset para obtener cantidad total de nombres
		if [ $# -eq 1 ]			# VALIDACIÓN: Verifica que se haya ingresado únicamente un argumento con la cantidad de imágenes
		then
			if [ $1 -le $CANT_NOMBRES ]		# VALIDACIÓN: Verifica que se haya ingresado un número menor a la cantidad disponible de nombres
			then
				# Creación de carpeta donde descargará las imágenes generadas y asignación de permisos a la misma
				mkdir imagenes_descargadas
				chmod +rwx imagenes_descargadas
				# Creación de archivo donde se guardarán los nombres utilizados y aisgnación de permisos al mismo
				touch nombres_usados.txt
				chmod +rwx nombres_usados.txt
				for i in $(seq 1 $1)
				do
					while :
					do
						# Se genera un número aleatorio entre 1 y la cantidad de nombres disponibles
						NUM_RANDOM=$(($RANDOM%$CANT_NOMBRES))
						# Asignamos el nombre de la fila elegida aleatoriamente
						NOMBRE=$(head -$NUM_RANDOM $ARCHIVO_NOMBRES | tail -1 | cut -d ',' -f 1)
						# HEAD toma las primeras X filas del dataset, TAIL tomará la última fila de la salida del comando anterior
						# El comando CUT extrae porciones de texto, -d permite elegir un delimitador, -f especifica el campo que se quiere extraer

						# Se cuenta cuántas veces se usó el nombre elegido aleatoriamente
						CANT_USO_NOMBRE=$(cat nombres_usados.txt | egrep "$NOMBRE" | wc -l)
						# Si el nombre no se usó aún, se sale del while, sinó se busca otro nombre
						if [ $CANT_USO_NOMBRE -eq 0 ]
						then
							break
						fi
					done
					# Se agrega nombre a la lista de nombres ya usados
					echo $NOMBRE >> nombres_usados.txt

					NOMBRE_IMAGEN="${RUTA_IMAGENES}/${NOMBRE}.jpeg"

					# Se verifica que haya comunicación con la URL de generación de imágenes
					if [ $i -eq 1 ]
					then
						echo "Comprobando conexión con el sitio $URL_IMAGENES..."
					fi
					for REINTENTOS_CONEXION in {1..3}
					do
						wget --spider -q $URL_IMAGENES
						# --spider recorre los enlaces de la página web sin descargar ningún archivo
						# -q hace que no salgan mensajes en la terminal a menos que ocurra algún error

						# Si hay comunicación con la URL de generación de imágenes, se genera la imágen con el nombre elegido
						# y se descarga en la ruta correspondiente
						if [ $? -eq 0 ]
						then
							for REINTENTOS_DESCARGA in {1..3}
							do
								echo "Generando imagen $i de $1, intento $REINTENTOS_DESCARGA de 3."
								wget --read-timeout=5 -q -O "$NOMBRE_IMAGEN" $URL_IMAGENES
								# -q hace que no salgan mensajes en la terminal a menos que ocurra algún error
								# -O sirve para especificar el nombre de archivo de salida
								if [ $? -eq 0 ]
								then
									sleep 2
									break 2
								fi
							done
						fi
						sleep 1
					done

					# VALIDACIÓN: Verifica que la imágen generada se haya descargado correctamente
					if [ -e "$NOMBRE_IMAGEN" ]
					then
						continue
					else
						echo -e "\e[31mERROR: Hubo problemas en la generación de imágenes, se aborta la operación.\e[0m"
						echo -e "\e[31mCompruebe la conexión a internet y vuelva a intentarlo.\e[0m"
						rm -r $RUTA_IMAGENES
						rm nombres_usados.txt
						exit 5
					fi
				done
				echo "Se han generado las siguientes imágenes:"
				ls $RUTA_IMAGENES
				rm nombres_usados.txt
				cd $RUTA_IMAGENES

				# Compresión de imágenes y generación de checksum
				echo "Comprimiendo imágenes..."
				zip -r $RUTA_TRABAJO/imagenes_comprimidas.zip ./
				md5sum $RUTA_TRABAJO/imagenes_comprimidas.zip > $RUTA_TRABAJO/checksum_md5.txt

				# Eliminación de archivo temporal
				rm -r $RUTA_IMAGENES

				echo -e "\e[32mGenerado con éxito el archivo comprimido con las imágenes.\e[0m"
				exit 0
			else
				echo -e "\e[31mERROR: Argumento incorrecto. Se debe ingresar un número entero comprendido entre 1 y ${CANT_NOMBRES}.\e[0m"
				exit 4
			fi
		else
			echo -e "\e[31mERROR: Ha ingresado $# argumentos, debe ingresar tan sólo un argumento (cantidad de imágenes a generar).\e[0m"
			exit 3
		fi
	else
		echo -e "\e[31mERROR: El archivo con lista de nombres no tiene permisos de lectura.\e[0m"
		exit 2
	fi
else
	echo -e "\e[31mERROR: No se encuentra el archivo con la lista de nombres.\e[0m"
	exit 1
fi
