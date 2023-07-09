FROM ubuntu
# Descarga la imagen 'latest' de Ubuntu
MAINTAINER Grupo1EdP
# Setea esto como Maintainer
RUN apt-get update
# Actualiza la información sobre los paquetes disponibles en los repositorios
RUN apt-get install -y imagemagick
# Instala el paquete ImageMagick
RUN apt-get install -y zip
# Instala el paquete zip
RUN apt-get install -y wget
# Instala el paquete wget
RUN apt-get install -y ucommon-utils
# Instala el paquete que contiene md5sum
RUN apt-get clean
# Limpia la caché 
RUN rm -rf /var/lib/apt/lists/*
# Limpia
RUN mkdir /home/scripts
# Crea carpeta que contendrá los scripts
RUN mkdir /home/salida
# Crea carpeta que contendrá el comprimido final con las imágenes
ADD [ "generar.sh" , "/home/scripts/" ]
# Mueve generar.sh a la ruta de trabajo
ADD [ "descomprimir.sh" , "/home/scripts/" ]
# Mueve descomprimir.sh a la ruta de trabajo
ADD [ "procesar.sh" , "/home/scripts/" ]
# Mueve procesar.sh a la ruta de trabajo
ADD [ "comprimir.sh" , "/home/scripts/" ]
# Mueve comprimir.sh a la ruta de trabajo
ADD [ "menu.sh" , "/home/scripts/" ]
# Mueve menu.sh a la ruta de trabajo
ADD [ "dataset.csv" , "/home/scripts/" ]
# Mueve dataset.csv a la ruta de trabajo
ENTRYPOINT [ "/bin/sh" ]
# Inicializa el contenedor con Shell
