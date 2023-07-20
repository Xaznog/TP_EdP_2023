#!/bin/bash

# Inclusión de script con funciones
source funciones.sh

# Valida instalación de Docker
validar_instalacion "docker" "Docker"

# Verifica que haya conexión a internet
ping -c 3 "www.google.com" > /dev/null 2>&1
# -c xx indica el número de paquetes de ping que se enviarán
# > /dev/null se utiliza para redirigir la salida estándar y que no se muestre por consola
# 2>&1 se utiliza para redirigir la salida de error estándar a la misma ubicación que la salida estándar

# Si hay conexión a internet se procede a la creación de la imagen y posterior ejecución del contenedor
if [ $? -eq 0 ]; then

    # Limpieza de archivos de ejecuciones anteriores
    elimina_archivo output

    # Creación de carpeta que contendrá el comprimido con las imágenes y asinación de permisos
    mkdir output
    chmod 764 output

    # Construcción de la imagen a partir del Dockerfile
    docker build --tag img_tp_edp_tuia:1.0 .

    # Ejecución del contenedor y mapeo de cvolúmen para carpeta de salida
    docker run -v ./output:/home/salida -it --name tp_edp_tuia img_tp_edp_tuia:1.0

    # Eliminación de contenedor tras la ejecución y finalización del programa
    docker rm tp_edp_tuia

    # Eliminación de la imagen de Docker
    docker rmi img_tp_edp_tuia:1.0

    clear
else
    echo -e "\e[31mERROR: Compruebe la conexión a internet y vuelva a intentarlo.\e[0m"
    exit 2
fi

exit 0