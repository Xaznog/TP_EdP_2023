#!/bin/bash

# Construcción de la imagen a partir del Dockerfile
docker build --tag img_tp_edp_tuia:1.0 .

# Ejecución del contenedor y mapeo de cvolúmen para carpeta de salida
docker run -v ./output:/home/salida -it --name tp_edp_tuia img_tp_edp_tuia:1.0