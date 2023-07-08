#!/bin/bash

# Una vez procesadas las imágenes se debe generar un archivo con la lista de todas las personas, un total de personas femeninas y masculinas; y luego comprimir todo en un solo archivo.
# Entiéndase por persona femenina aquella cuya ultima letra del primer nombre es una letra “a”.
# El archivo generado debe poder accederse fuera del contenedor.

RUTA_IMAGENES_PROC="/home/tuia/EdP/TP/imagenes_descargadas/nuevas_imagenes"
#REG_EXP_MUJERES="^[A-Z][a-z]+a(\s[A-Z][a-z]+)?\.(.+)?$"
#REG_EXP_PERS="^[A-Z][a-z]+(\s[A-Z][a-z]+)?\.(.+)?$"
REG_EXP_MUJERES="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+a(\s[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+)?\.(.+)?$"
REG_EXP_PERS="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+(\s[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+)?\.(.+)?$"
RUTA_COMPRIMIDO="/home/tuia/EdP/TP"
RUTA_IMAGENES="/home/tuia/EdP/TP/imagenes_descargadas"

chmod +rwx $RUTA_IMAGENES_PROC

if [ -e $RUTA_IMAGENES_PROC ]
then
	cd $RUTA_IMAGENES_PROC
	if [ -e lista_nombres.txt ]
	then
		rm lista_nombres.txt
	fi
	if [ "$(ls -A $RUTA_IMAGENES)" ]
	then
		echo "Creando lista de nombres..."
		echo "Los nombres de las personas en las imágenes son:" > lista_nombres.txt
	        for ARCHIVO in $RUTA_IMAGENES_PROC/*
		do
        		AUX_ARCHIVO=$(basename "$ARCHIVO")
			if [[ $AUX_ARCHIVO =~ $REG_EXP_PERS ]]
			then
                		#NOMBRE=$(basename "$AUX_ARCHIVO" .JPG)
                		#echo $NOMBRE >> lista_nombres.txt
                		echo ${AUX_ARCHIVO%.*} >> lista_nombres.txt # ${} se usa para strings, el "%" elimina patrones, el "." es un punto y el "*" es cualquier cosa. Todo esto hace lo mismo que las dos líneas anteriores
            		fi
        	done
		echo "Calculando cantidad de imágenes de hombres y de mujeres..."
		CANT_PERSONAS=$(ls | egrep $REG_EXP_PERS | wc -l)	# Cuenta la cantidad de hombres y mujeres
		CANT_MUJERES=$(ls | egrep $REG_EXP_MUJERES | wc -l)	# Cuenta la cantidad de mujeres
		CANT_HOMBRES=$(($CANT_PERSONAS-$CANT_MUJERES))		# Calcula la cantidad de hombres
		echo "La cantidad de personas femeninas es de: $CANT_MUJERES" >> lista_nombres.txt
		echo "La cantidad de personas masculinas es de: $CANT_HOMBRES" >> lista_nombres.txt
		echo "Comprimiendo imágenes..."
		zip -r $RUTA_COMPRIMIDO/imagenes_comprimidas.zip ./			# Esto comprime
		cat lista_nombres.txt
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

