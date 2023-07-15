# Trabajo Práctico Final - Entorno de Programación

## Introducción
En este repositorio, se encuentran los archivos que componen el Trabajo Práctico Final para la materia Entorno de Programación de la Tecnicatura en Inteligencia Artificial. Los integrantes del grupo de estudiantes que realizó este trabajo fueron:

| Estudiante | Legajo |
| ----- | --- |
|Alanis, Germán | A-4616/7 |
|Asad, Gonzalo | A-4595/1 |
|Castells, Sergio | C-7334/2 |

El Trabajo Práctico consistió en la elaboración de un programa dividido en cinco scripts que corren dentro de un contenedor. De ejecutarse el programa en el orden correcto, se obtendrá cómo resultado en la computadora que aloja al contenedor un archivo comprimido con imágenes de personas y tres archivos de texto.
Las imágenes de personas se llaman con nombres de personas, de los cuáles sólo se consideran nombres válidos como los que comienzan en mayúsculas en cada uno de sus nombres. Las imágenes con nombres válidos son procesadas y modificadas en tamaño. Los archivos de texto contienen información como: lista de nombres válidos, cantidad de nombres válidos que terminan con la letra "a" y lista de nombres de todos los archivos.

## Requisitos Previos
Para poder ejecutar el programa correctamente, se requerirá que el usuario
- Ejecute el Trabajo Práctico en alguna distribución de Linux
- Posea conocimientos básicos del uso de la terminal de Shell en Linux
- Tenga instalado Docker en la PC donde se correrá el programa (si no lo tiene instalado, puede seguir el instructivo en el siguiente enlace: https://docs.docker.com/desktop/install/linux-install/)

## Cómo Iniciar el Contenedor
### Paso #1:
Al descargar el contenido del repositorio, el usuario deberá asegurarse que todos los archivos del mismo se encuentren dentro de un único directorio en la PC donde correrá el programa, como en el siguiente ejemplo:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/bdb1dfa9-07e5-4719-ab36-dd7465b836cd)

### Paso #2:
A continuación, se deberá abrir una terminal de Shell y navegar hasta el directorio que contiene los archivos del repositorio con el siguiente comando:

```shell
cd "Ruta_del_directorio"
```

Ejemplo:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/3ea5d0e2-6ee2-4a1a-8ae1-8850410ef7fc)

### Paso #3:
Una vez ubicado en el directorio del repositorio, deberá asignarle permisos de ejecución al archivo _startdocker.sh_ con el comando:

```shell
chmod +x startdocker.sh
```

Ejemplo:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/f626cce4-9908-4a36-837f-13ebc9035a47)

### Paso #4:
Finalmente, deberá ejecutar el archivo _startdocker.sh_, lo que dará inicio a la creación de la imagen de Docker, al contenedor y a la ejecución del programa del Trabajo Práctico:

```shell
./startdocker.sh
```

Ejemplo:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/5f9cbb3d-222d-45b2-bea1-646b1fce4b33)

Si todos los pasos fueron cumplidos, se debería ver en la terminal la creación de la imágen y a continuación un mensaje de bienvenida al Trabajo Práctico de Entorno de Programación, dando inicio al programa:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/234f3145-1b7d-4687-b1d7-a9fab0e79ccf)

## Cómo Usar el Programa
Al iniciar el programa, el usuario verá en pantalla un menú con 5 opciones:
- Generar
- Descomprimir
- Procesaro
- Comprimir
- Salir

Si bien el usuario puede elegir cualquier opción, para una correcta ejecución del programa se debe seguir un orden determinado. De no seguir ese orden, se le dará aviso al usuario para que ejecute los pasos anteriores. Para elegir la opción, el usuario deberá ingresar el número correspondiente y a continuación presionar el botón _Enter_ del teclado.
Dicho esto, la ejecución sugerida que arrojará como resultado el archivo comprimido antes mencionado en la PC donde se ejecuta el programa, será descripto a continuación.

### Paso #1: Generar
Esta opción busca y genera una cantidad definida por el usuario de imágenes de internet, las descarga y las guarda dentro de un archivo comprimido junto con su checksum dentro del contenedor.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _1_ con el teclado y a continuación presionar el botón _Enter_. Se le pedirá que ingrese cuántas imágenes desea generar, ingresar el número con el teclado seguido de presionar el botón _Enter_:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/dcf413c7-9474-4203-9319-bf2b1d36de6f)

Verá mensajes indicando que las imágenes están siendo generadas:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/dc0e7fc2-0e9b-4329-a2ed-6c26bc8dcde6)

Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/bf94b2d7-b5ac-4066-a1f2-9815cf5a4846)

### Paso #2: Descomprimir
Esta opción hacé una suma de verificación entre el checksum y el archivo comprimido generados por la opción anterior. Posteriormente, descomprime las imágenes en un directorio dentro del contenedor.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _2_ con el teclado y a continuación presionar el botón _Enter_. Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/c3d2bfe7-fbe6-4eb8-83f6-a4a6a6b0b4b3)

### Paso #3: Procesar
Esta opción modifica el tamaño de las imágenes generadas que tienen un nombre válido. Las que no tienen un nombre válido, son mantenidas igual.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _3_ con el teclado y a continuación presionar el botón _Enter_. Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/88eccae9-6a88-45e8-878a-b3afdc6e9a13)

### Paso #4: Comprimir
Esta opción mgenera un archivo comprimido que contiene las imágenes generadas además de tres archivos de texto que contienen: lista de nombres válidos, cantidad de nombres válidos que terminan con la letra "a" y lista de nombres de todos los archivos.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _4_ con el teclado y a continuación presionar el botón _Enter_. Al finalizar, se le dará aviso al usuario de que el proceso se realizó exitosamente:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/d8067996-bc58-4d46-a2d3-0b5b7371c4ee)

### Paso #5: Salir
Esta opción finaliza la ejecución del programa y detiene al contenedor.
Para ejecutar esta opción, teniendo el menú en pantalla, el usuario deberá ingresar _5_ con el teclado y a continuación presionar el botón _Enter_.

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/7bdff22d-82f3-4d50-b671-b06fe5c02b27)

El usuario deberá verse de regreso a la terminal de Shell de su PC:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/9cce156c-36dc-4096-a858-5eed23c24eb8)

### Paso 6: Obtención de Imágenes
Si todos los pasos fueron realizados exitosamente, el usuario deberá ver que se creó un nuevo directorio llamado _output_ dentro del directorio del repositorio.

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/5914b61e-e9c5-4892-94ac-ab799d638467)

El directorio contendrá un archivo comprimido con las imágenes generadas y los archivos de texto antes mencionados.

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/419271cb-ca97-4846-815f-e4e6876b9940)

## Limpieza
Se sugiere que tras la ejecución del programa y la obtención del archivo comprimido, el usuario realice una eliminación del contenedor y de la imagen de Docker generados. Para hacerlo, primero se debe eliminar el contenedor ingresando el siguiente comando en una terminal de Shell:

```shell
docker rm tp_edp_tuia
```

Ejemplo:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/82ca2549-c158-4954-bba5-6589a258055b)

A continuación, para eliminar la imagen de Docker deberá ingresar el siguiente comando en la terminal de Shell:

```shell
docker rmi img_tp_edp_tuia
```

Ejemplo:

![image](https://github.com/Xaznog/TP_EdP_2023/assets/101712284/c6d8c483-bd6f-4c69-85c4-e1413fc9c4cd)
