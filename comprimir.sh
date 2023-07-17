#!/bin/bash

# Finalmente, luego de procesadas las imágenes, se debe:
# – generar un archivo con la lista de nombres de todas las imágenes.
# – generar un archivo con la lista de nombres válidos.
# – generar un archivo con el total de personas cuyo nombre finaliza con la letra a.
# – por último, generar un archivo comprimido que incluya los archivos generados en los items anteriores y todas las imágenes.
# El archivo comprimido debe poder accederse desde fuera del contenedor.

# Inclusión de script con funciones
source /home/scripts/funciones.sh

# Creación de variables
REG_EXP_VAL_FIN_A="^[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+a(\s[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+)*\.(.+)?$"	# Expresión regular de nombres válidos que terminan en "a"
REG_EXP_VAL="^[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+(\s[A-ZÁÉÍÓÚÑàèìòù][a-záéíóúñàèìòù]+)*\.(.+)?$"			# Expresión regular de nombres válidos
RUTA_COMPRIMIDO="/home/salida/"							# Ruta donde se alojará el archivo comprimido de salida
RUTA_IMAGENES="/home/scripts/imagenes_descargadas"		# Ruta que contiene las imágenes a comprimir

if [ -e $RUTA_IMAGENES ]			# VALIDACIÓN: Verifica existencia de directorio con imágenes a comprimir
then
	# Navegación a ruta de trabajo
	cd $RUTA_IMAGENES

	# Limpieza de archivos de ejecuciones anteriores
	elimina_archivo lista_nombres_imagenes.txt
	elimina_archivo lista_nombres_val.txt
	elimina_archivo cant_nombres_val_fin_a.txt

	if [ "$(ls -A $RUTA_IMAGENES)" ]	# VALIDACIÓN: Verifica si la carpeta tiene contenido. -A no lista . y ..
	then
		echo "Creando listas con detalles de nombres..."
		LISTA_NOMBRES=$(ls)
		echo -e "Los nombres de todas las imágenes son:\n$LISTA_NOMBRES" > lista_nombres_imagenes.txt
		# El -e habilita el uso de escapes con \
		echo "Los nombres válidos son:" > lista_nombres_val.txt

		for ARCHIVO in $RUTA_IMAGENES/*		# Itera sobre los archivos contenidos en el directorio
		do
        	AUX_ARCHIVO=$(basename "$ARCHIVO")	# Se alamcena únicamente el nombre de archivo, sin la ruta
			if [[ $AUX_ARCHIVO =~ $REG_EXP_VAL ]]	# Se compara el nombre del archivo con la expresión regular de nombre válido
			then
        		echo ${AUX_ARCHIVO%.*} >> lista_nombres_val.txt
				# ${} se usa para strings, el "%" elimina patrones, el "." es un punto y el "*" es cualquier cosa
				# Con esto, se logra eliminar todo lo que está a la derecha del punto (la extensión del archivo y el salto de línea)
            fi
        done

		CANT_VAL_FIN_A=$(ls | egrep $REG_EXP_VAL_FIN_A | wc -l)	# Cuenta la cantidad de nombres válidos que terminen en "a"
		echo "La cantidad de nombres válidos que terminan en 'a' es de: $CANT_VAL_FIN_A" > cant_nombres_val_fin_a.txt

		# Compresión de imágenes
		echo "Comprimiendo imágenes..."
		zip -r $RUTA_COMPRIMIDO/imagenes_comprimidas.zip ./
		# -r hace una compresión recursiva del contenido del directorio

		# Eliminación de directorio con imágenes sin comprimir. En este punto ya no es necesario
		rm -r $RUTA_IMAGENES

		echo -e "\e[32mFinalizada la compresión de imágenes.\e[0m"
		exit 0
	else
		echo -e "\e[31mERROR: La carpeta está vacía, asegúrese de realizar primero los pasos de GENERAR, DESCARGAR y PROCESAR en ese orden.\e[0m"
		exit 2
	fi
else
	echo -e "\e[31mERROR: La carpeta con las imágenes no existe, realizar primero los pasos de GENERAR, DESCARGAR y PROCESAR en ese orden.\e[0m"
	exit 1
fi

