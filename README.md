# Trabajo Práctico Final - Entorno de Programación

## Introducción
En este repositorio, se encuentran los archivos que componen el trabajo práctico final para la materia Entorno de Programación de la Tecnicatura Universitaria en Inteligencia Artificial. Este trabajo fue realizado por:

| Estudiante | Legajo |
| ----- | --- |
|Alanis, Germán | A-4616/7 |
|Asad, Gonzalo | A-4595/1 |
|Castells, Sergio | C-7334/2 |

El trabajo práctico consistió en la elaboración de un programa dividido en varios scripts que corren dentro de un contenedor. De ejecutarse el programa en el orden correcto, se obtendrá como resultado un archivo comprimido con imágenes de personas y tres archivos de texto.
La nomenclatura de las imágenes corresponde a nombres de personas, de los cuáles sólo se consideran válidos aquellos que comienzan en mayúsculas y continúan en minúsculas. Las imágenes con nombres válidos son procesadas y modificadas en tamaño. Los archivos de texto contienen la siguiente información: lista de nombres válidos, cantidad de nombres válidos que terminan con la letra "a" y lista de nombres de todos los archivos.

## Requisitos Previos
Para poder ejecutar el programa correctamente, se requerirá que el usuario
- Cuente con un sistema operativo Linux
- Posea conocimientos básicos del uso de Shell en Linux
- Tenga instalado Docker en la PC donde se correrá el programa (si no lo tiene instalado, puede seguir el instructivo en el siguiente enlace: https://docs.docker.com/desktop/install/linux-install/)

## Cómo Iniciar el Contenedor
### Paso #1:
Al descargar el contenido del repositorio, el usuario deberá asegurarse que todos los archivos del mismo se encuentren dentro de un único directorio en la PC donde correrá el programa, como en el siguiente ejemplo:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/3b3a74c0-2eb5-4b54-903d-5b03e7cb7e31)

### Paso #2:
A continuación, se deberá abrir una terminal de Shell y navegar hasta el directorio que contiene los archivos del repositorio con el siguiente comando:

```shell
cd "Ruta_del_directorio"
```

Ejemplo:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/01de8b3b-685e-460a-b8b6-512b46b576d7)

### Paso #3:
Una vez ubicado en el directorio del repositorio, deberá asignarle permisos de ejecución al archivo _startdocker.sh_ con el comando:

```shell
chmod +x startdocker.sh
```

Ejemplo:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/66c69dc7-8b86-43b9-a7de-a4ad7cb1c2fe)

### Paso #4:
Finalmente, deberá ejecutar el archivo _startdocker.sh_, lo que dará inicio a la creación de la imagen de Docker, al contenedor y a la ejecución del programa:

```shell
./startdocker.sh
```

Ejemplo:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/6b9b20d1-bba4-4a12-8fbf-b3d719a682df)

Si todos los pasos fueron ejecutados satisfactoriamente, se deberá ver en la terminal la creación de la imágen y a continuación un mensaje de bienvenida al trabajo práctico de Entorno de Programación, dando inicio al programa:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/1705ea6a-d86e-4857-a040-5c32dbb5c7c0)

## Cómo Usar el Programa
Al iniciar el programa, el usuario verá en pantalla un menú con 5 opciones: \
1\) Generar \
2\) Descomprimir \
3\) Procesar \
4\) Comprimir \
5\) Salir 

Si bien el usuario puede elegir cualquier opción en cualquier orden, para una correcta ejecución del programa se debe seguir una secuencia determinada que será indicada por el mismo acusando la opción que debe seleccionar en cursiva y parpadeando. De verse esta secuencia alterada, se le dará aviso al usuario para que ejecute los pasos en el orden correcto. Para elegir la opción, el usuario deberá ingresar el número asociado a la misma y a continuación presionar el botón _Enter_ del teclado.
La correcta ejecución arrojará como resultado el archivo comprimido antes mencionado que se alojará en la PC donde se ejecuta el programa.

### Paso #1: Generar
Esta opción genera una cantidad de imágenes definida por el usuario haciendo uso de un servicio en internet, las descarga y las guarda dentro de un archivo comprimido, junto con su checksum, dentro del contenedor.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _1_ con el teclado y a continuación presionar la tecla _Enter_. Se le pedirá que ingrese cuántas imágenes desea generar, ingresar el número con el teclado y presionar _Enter_:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/a31c040b-7666-48df-be55-8b970bfd5abb)

Verá mensajes indicando que las imágenes están siendo generadas:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/9c53700f-4f26-4499-af95-a984ce3b6ff6)

Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/dde5fe06-5b80-4852-bff3-6daf20c54a63)

### Paso #2: Descomprimir
Esta opción hace una suma de verificación entre el checksum y el archivo comprimido generados por la opción anterior. Posteriormente, descomprime las imágenes en un directorio dentro del contenedor.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _2_ con el teclado y a continuación presionar la tecla _Enter_. Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/87be09e9-f42d-4312-a784-fa12cff33da9)

### Paso #3: Procesar
Esta opción modifica el tamaño de las imágenes generadas cuyo nombre es válido. Las que no tienen un nombre válido, se conservan sin alterar.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _3_ con el teclado y a continuación presionar la tecla _Enter_. Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/f5e053c8-5ef2-44c4-bf4d-6cf62dccb0ee)

### Paso #4: Comprimir
Esta opción genera un archivo comprimido que contiene las imágenes generadas además de tres archivos de texto que contienen: lista de nombres válidos, cantidad de nombres válidos que terminan con la letra "a" y lista de nombres de todos los archivos.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _4_ con el teclado y a continuación presionar la tecla _Enter_. Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/5da8e494-ac54-4e21-bee6-95469c36a4cd)

### Paso #5: Salir
Esta opción finaliza la ejecución del programa y detiene el contenedor.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _5_ con el teclado y a continuación presionar la tecla _Enter_.

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/ba95ed68-4a9c-4d77-8e1e-e959ffb44eca)

El usuario deberá verse de regreso a la terminal de Shell de su PC:

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/43b19790-c560-4a61-a165-8666647fbebd)

### Paso 6: Obtención de Imágenes
Si todos los pasos fueron realizados exitosamente, el usuario deberá ver que se creó un nuevo directorio llamado _output_ dentro del directorio del repositorio.

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/09c59f89-1163-40f2-a2bf-d26793a47056)

El directorio contendrá un archivo comprimido con las imágenes generadas y los archivos de texto antes mencionados.

![imagen](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/ffec9b65-78e1-43b8-b0c2-ddaa23f67bcc)

## Limpieza
Tras la ejecución del programa y la obtención del archivo comprimido, se realizará una rutina de limpieza automática que consiste en la eliminación del contenedor y de la imagen de Docker generados. 
