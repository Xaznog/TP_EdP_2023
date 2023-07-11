#!/bin/bash

docker build --tag img_tp_edp_tuia:1.0 .

docker run -v ./output:/home/salida -it --name tp_edp_tuia img_tp_edp_tuia:1.0
