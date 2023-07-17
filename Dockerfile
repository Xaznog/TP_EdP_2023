# Descarga la imagen 'latest' de Ubuntu
FROM ubuntu
# Setea esto como Maintainer
MAINTAINER Grupo1EdP
# Actualiza la información sobre los paquetes disponibles en los repositorios
RUN apt-get update
# Instala el paquete ImageMagick
RUN apt-get install -y imagemagick
# Instala el paquete zip
RUN apt-get install -y zip
# Instala el paquete wget
RUN apt-get install -y wget
# Instala el paquete que contiene md5sum
RUN apt-get install -y ucommon-utils
# Limpia la caché 
RUN apt-get clean
# Limpia la información de paquetes descargados
RUN rm -rf /var/lib/apt/lists/*
# Crea carpeta que contendrá los scripts
RUN mkdir /home/scripts
# Crea carpeta que contendrá el comprimido final con las imágenes
RUN mkdir /home/salida
# Mueve los archivos del programa a la ruta de trabajo
ADD [ "generar.sh" , "/home/scripts/" ]
ADD [ "descomprimir.sh" , "/home/scripts/" ]
ADD [ "procesar.sh" , "/home/scripts/" ]
ADD [ "comprimir.sh" , "/home/scripts/" ]
ADD [ "menu.sh" , "/home/scripts/" ]
ADD [ "funciones.sh" , "/home/scripts/" ]
ADD [ "dataset.csv" , "/home/scripts/" ]
# Asigna permisos de ejecución a los archivos del programa
RUN chmod 764 /home/scripts/generar.sh
RUN chmod 764 /home/scripts/descomprimir.sh
RUN chmod 764 /home/scripts/procesar.sh
RUN chmod 764 /home/scripts/comprimir.sh
RUN chmod 764 /home/scripts/menu.sh
RUN chmod 764 /home/scripts/funciones.sh
RUN chmod 764 /home/scripts/dataset.csv
# Inicializa el contenedor directamente en el menú del programa
ENTRYPOINT [ "/home/scripts/menu.sh" ]

