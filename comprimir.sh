#!/bin/bash

# Finalmente, luego de procesadas las imágenes, se debe:
# – generar un archivo con la lista de nombres de todas las imágenes.
# – generar un archivo con la lista de nombres válidos.
# – generar un archivo con el total de personas cuyo nombre finaliza con la letra a.
# – por último, generar un archivo comprimido que incluya los archivos generados en los items anteriores y todas las imágenes.
# El archivo comprimido debe poder accederse desde fuera del contenedor.

#RUTA_IMAGENES_PROC="/home/tuia/EdP/TP/imagenes_descargadas/nuevas_imagenes"
REG_EXP_VAL_FIN_A="^[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+a(\s[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+)*\.(.+)?$"
REG_EXP_VAL="^[A-ZÁÉÍÓÚÑÀÈÌÒÙ][a-záéíóúñàèìòù]+(\s[A-ZÁÉÍÓÚÑàèìòù][a-záéíóúñàèìòù]+)*\.(.+)?$"
RUTA_COMPRIMIDO="/home/salida/"
RUTA_IMAGENES="/home/scripts/imagenes_descargadas"

#chmod +rwx $RUTA_IMAGENES_PROC

if [ -e $RUTA_IMAGENES ]
then
	cd $RUTA_IMAGENES
	if [ -e lista_nombres_imagenes.txt ]
	then
		rm lista_nombres_imagenes.txt
	fi
	if [ -e lista_nombres_val.txt ]
	then
		rm lista_nombres_val.txt
	fi
	if [ -e cant_nombres_val_fin_a.txt ]
	then
		rm cant_nombres_val_fin_a.txt
	fi
	if [ "$(ls -A $RUTA_IMAGENES)" ]	# Evalúa si la carpeta tiene contenido
	then
		echo "Creando listas con detalles de nombres..."
		LISTA_NOMBRES=$(ls)
		echo -e "Los nombres de todas las imágenes son:\n$LISTA_NOMBRES" > lista_nombres_imagenes.txt	# El -e habilita el uso de escapes con \
		echo "Los nombres válidos son:" > lista_nombres_val.txt
		for ARCHIVO in $RUTA_IMAGENES/*
		do
        		AUX_ARCHIVO=$(basename "$ARCHIVO")
			if [[ $AUX_ARCHIVO =~ $REG_EXP_VAL ]]
			then
                		#NOMBRE=$(basename "$AUX_ARCHIVO" .JPG)
                		#echo $NOMBRE >> lista_nombres.txt
                		echo ${AUX_ARCHIVO%.*} >> lista_nombres_val.txt # ${} se usa para strings, el "%" elimina patrones, el "." es un punto y el "*" es cualquier cosa. Todo esto hace lo mismo que las dos líneas anteriores
            		fi
        	done
		CANT_VAL_FIN_A=$(ls | egrep $REG_EXP_VAL_FIN_A | wc -l)	# Cuenta la cantidad de nombres válidos que terminen en "a"
		echo "La cantidad de nombres válidos que terminan en 'a' es de: $CANT_VAL_FIN_A" > cant_nombres_val_fin_a.txt
		echo "Comprimiendo imágenes..."
		zip -r $RUTA_COMPRIMIDO/imagenes_comprimidas.zip ./			# Esto comprime
		rm -r $RUTA_IMAGENES
		echo "Finalizada la compresión de imágenes."
		exit 0
	else
		echo "ERROR: La carpeta está vacía, asegúrese de realizar primero los pasos de GENERAR, DESCARGAR y PROCESAR en ese orden."
		exit 2
	fi
else
	echo "ERROR: La carpeta con las imágenes no existe, realizar primero los pasos de GENERAR, DESCARGAR y PROCESAR en ese orden."
	exit 1
fi

