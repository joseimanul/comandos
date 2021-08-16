#!/bin/bash

#DNS (Domain Name Server)
#Instalación de BIND (Berkely Internet Name Domain) Este es un software comunmente utilizado para obtener las direcciones ip, a partir de los nombres de los dominios
    #Ubuntu
        #Para instalar bind en ubuntu, debemos saber como se llama este paquete dentro apt, para obtener esta información, instalamos primero un programa que me va a el nombre de los paquetes a instalar en apt y su descripción, este paquete se llama aptitude
        apt install -y aptitude
        #una vez instalamos aptitude, buscamos el nombre de bind que vamos a instalar
        aptitude search "?name(^bind)" #El resultado de esta busqueda, me dice que hay un software llamado bind9, que sirve para "Internet Domain Name Server", paso a utilizar este nombre entonces
        #Para instalar bind9, uso entonces el programa apt
        apt install -y bind9
        #El programa bind9 escucha por el puerto 53, vamos a validar por el nestat, que esté escuchando
        netstat -ltnp

#Apache2
    #Ubuntu
    apt install apache2
    #Red hat
    yum install apache2

#Nginx
    #Ubuntu
    apt install -y nginx nginx-extras
    #Red Hat
    yum install epel-release
    yum update
    yum -y install nginx
    nginx -v


