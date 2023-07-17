#!/bin/bash

# Valida instalación de Docker
EXISTE_DOCKER=$(whereis docker)
if [[ $EXISTE_DOCKER == "docker:" ]]; then
    echo -e "\e[31mERROR: Docker no está instalado. Instalelo y vuelva a intentar.\e[0m"
	exit 1
fi

# Se verifica que haya conexión a internet
CONT_REINTENTOS=0
for REINTENTOS_CONEXION in {1..3}; do
    wget --spider -q "www.google.com"
    # --spider recorre los enlaces de la página web sin descargar ningún archivo
    # -q hace que no salgan mensajes en la terminal a menos que ocurra algún error

    # Si hay conexión a internet se procede a la creación de la imagen y posterior ejecución del contenedor
    if [ $? -eq 0 ]; then

        # Construcción de la imagen a partir del Dockerfile
        docker build --tag img_tp_edp_tuia:1.0 .

        # Ejecución del contenedor y mapeo de cvolúmen para carpeta de salida
        docker run -v ./output:/home/salida -it --name tp_edp_tuia img_tp_edp_tuia:1.0
        break 
    else
        CONT_REINTENTOS=$(($CONT_REINTENTOS + 1))
        sleep 1
    fi
done

if (($CONT_REINTENTOS == 3)); then
    echo -e "\e[31mERROR: Compruebe la conexión a internet y vuelva a intentarlo.\e[0m"
    exit 2
fi
exit 0