#BASICOS
	man [nombre_proceso] #Con este comando puedo conocer mas acerca de un comando del sistema, desde linux, sin salir a internet
        man pwd

    pwd #directorio actual.

    ls #listar archivod
        ls -lrta #listar todos los arhcivos (-a), incluidos los ocultos, en forma de lista (-l), de forma ascendente, según su ulitma fecha de modificación (-tr)

	cd #Change Directory {nombre carpeta}: ingresar a esa carpeta.
        cd .. #regresar a la carpeta anterior

	clear #sirve para limpiar la pantalla

    touch # nos ayuda a crear archivos desde la terminal.	

	cat [nombre archivo] #me muestra el contenido de un archivo en su totalidad
        cat /etc/*-release #version de linux
	    cat /etc/passwd #listar usuarios
        cat /proc/cpuinfo | grep "processor" #Muestra información sobre el CPU
        etc/shadow #listar contraseñas, pero aparecen cifradas

    tail [nombre archivo] #nos muestra las últimas 10 líneas de nuestros archivos.
        tail -200 [nombre archivo] #últimas 200 lineas
        tail -f [nombre archivo] #nos muestra en tiempo real, lo que se va escrbiendo en el archivo

    head #nos muestra las primeras 10 líneas de nuestros archivos.
        head -200 [nombre archivo] #primeras 200 lineas

    less #nos ayuda a leer el contenido de nuestros archivos por páginas. Nos movemos con las flechas del teclado o la tecla de espacio. Salimos de la lectura del archivo con la letra q. Buscamos palabras específicas escribiendo /palabra.
        less /[cadena a buscar]

	grep [cadena a buscar] [archivo] #busca una cadena en un archivo.
        grep -lir [cadena a buscar] [ruta/archivo] #busca una cadena en un archivo, sin tener en cuenta el case-sensitive.

	ctrl + r #buscar comandos ejecutados

	history #historial de comandos

    which [Nombre_Programa]
        which java #donde está el programa java

    #PERMISOS 
        #Para cambiar los permisos de un archivo o directorio podemos usar el comando chmod + a quién queremos añadir o quitar los permisos:
        # El usuario propietario: u.
        # El grupo, g.
        # El resto de usuarios, o.
        # Para todos, a.
        chmod u+x [nombre archivo] #aqui agregamos permisos de ejecución sobre el usuario dueño

        #Cambiar dueño, de manera recursiva
        chown -R [nombre_usuario]:[nomrbre_grupo] [nombre_archivo]

    #USUARIOS
        #crea un usuario sin asignarle inmediatamente alguna contraseña ni consultar más información. Debemos terminar de configurar esta cuenta a mano posteriormente.
        sudo useradd [nombre_usuario]
        #crea un nuevo usuario con contraseña y algo más de información. También creará una nueva carpeta en la carpeta /home/.
        sudo adduser [nombre_usuario]
        #eliminar cuentas de usuarios.
        userdel [nombre_usuario]
        #modificar la información de alguna cuenta.
        usermod
        #Dar permisos de administrador a un usuario en ubuntu o sistemas basados en debian
        gpasswd -a nodejs sudo
        #Dar permisos de administrador a un usuario en redhat, o sistemas basados en centos
        gpasswd -a nodejs wheel

    #GRUPOS
        #Switch User, cambia de usuario
        su - [nombre_usuario]
        #Muestra a que grupos pertenece cierto usuario
        groups [nombre_usuario]
        #Agrega un usuario a un grupo principal
        sudo gpasswd -a [nombre_usuario] [nomrbre_grupo]
        #Quita a un usuario de un grupo
        sudo gpasswd -d [nombre_usuario] [nomrbre_grupo]
        #Agrega un usuario a un grupo secundario
        usermod -aG [nomrbre_grupo] [nombre_usuario]
        #Muestra que permisos tiene el usuario actual
        sudo -l

    #SERVICIOS
        sudo systemctl status servicio #Estado de un servicio
        sudo systemctl enable servicio #Habilita un servicio
        sudo systemctl disable servicio #Deshabilita un servicio
        sudo systemctl start servicio #Enciende un servicio
        sudo systemctl stop servicio #Apaga un servicio
        sudo systemctl restart servicio #Reinicia un servicio
        sudo systemctl list-units -t service --all #Lista los servicios del sistema

    #SERVICIOS SISTEMA OPERATIVO
    #El comando journalctl nos permite ver los logs de los procesos de nuestro sistema operativo. Recuerda que todos ellos están almacenados en la carpeta /var/log/.
        sudo journalctl -fu servicio #Muestra el log de un servicio
        sudo journalctl --disk-usage #Muestra cuanto pesan los logs en el sistema operativo
        sudo journalctl --list-boots #Muestra los booteos de la computadora
        sudo journalctl -p critic|notice|info|warning|error #Muestra mensajes de determinada categoría de nuestros logs
        sudo journalctl -o json  #Muestra los logs en formato json
    
    #PROCESOS
        #Este comando me va a listar todos los procesos del sistema, y los va a filtrar por el nombre de proceso que yo le asigne
        ps -fea | grep [nombre_proceso]
        #Me permite ver que usuarios estan conectados por tty, en este caso, creo que solo aplica para los usuarios que están conectados directamente al servidor
        ps -fea | grep tty
        #Con este comando, puedo saber que usuarios están conectados al servidor desde ssh por ejemplo
        ps -fea | grep pts #Tambien se puede probar colocando ssh
        #Muestra los 5 procesos que más uso hacen del CPU
        ps auxf | sort -nr -k 3 | head -5 
        #Muestra los 5 procesos que más uso hacen de la memoria RAM
        ps auxf | sort -nr -k 4 | head -5 

    #Con este comando, matas inmediatamente a un proceso, esto puede ser un programa que esté corriendo, como tomcat, o un usuario que esté conectado al servidor
    kill - 9 [nombre_proceso]
    #con who y w, podemos ver quien está conectado al servidor, y desde donde
    who
    w
    #Este comando me permite saber con que usuerio me encuentro conectado
    whoami

    #Genera un archivo llamado “nohup.out” que muestra toda la información que produjo un proceso
    nohup

    #Me muestra información sobre la memoria de mi sistema. Con el modificador -h la información es más legible para un humano

    free -h
    #Muestra información sobre el disco duro. Con el modificador -hsc y un directorio especificado muestra el tamaño de ese directorio    
    du -hsc [nombre_directorio]

    #Funciona como top pero funciona de forma más intuitiva
    htop 

    #Para visualizar la puerta de enlace predeterminada del equipo. Muestra la IP routing table.
    route -n

    #Para identificar las IPs de diferentes dominios podemos usar el comando 
    nslookup nombredominio.ext
        nslookup demos-opencloud.openintl.com
    dig [nombre_dominio]
        dig demos-opencloud.openintl.com    

    #Realiza consultas a un servidor
    curl 
    #Permite descargar contenido de un servidor
    wget 

    #Con este comando podemos ver que tan seguras son las contraseñas
    pwscore #Para usar este comando, damos enter y ingresamos la contraseña que queremos validar, y volvemos a presionar enter

#Administración de paquetes acorde a la distribución
    # Red Hat / CentOS / Fedora
        #.rpm Red Hat Package Manager. Base de datos RPM, localizada en var/lib/rpm
        rpm -qa #Listar todos los rpms instalados en la máquina. (query all)
        rpm -i [paquete.rpm] #Realizar la instalación de un paquete. (install)
        rpm -e [paquete.rpm] #Remover un paquete del sistema. (erase)
        
        #YUM: Repositorios yum Permite instalar un paquete desde un repositorio sin tener que conocer la ruta del archivo o las dependencias.
        yum install [nombre_paquete]
        
        #Debian / Ubuntu
        #.deb Debian package management. Base de datos DPKG, localizada en /var/lib/dpkg
        dpkg -l #Listar todos los debs instalados en la máquina.
        dpkg -i [paquete.deb] #Realizar la instalación de un paquete.
        dpkg -r [paquete.deb] #Remover un paquete del sistema.
        dpkg-reconfigure
        dpkg-reconfigure [nombre_paquete].deb #Volver a ejecutar el asistente de configuración si está disponible.
            dpkg-reconfigure tzdata #tzdata es el paquete que configura la hora del servidor. Para reconfigurarlo este comando
        
        #APT: repositorios apt otra forma de instalar.
        apt install [nombre_paquete]
        apt update #Actualiza la información local sobre los repositorios de Ubuntu
        apt upgrade #Actualiza todos los programas que tenemos instalados en la máquina
        apt dist-upgrade #Realiza actualizaciones a escala de kernel. Estas actualizaciones siempre requieren reinicio, a no de ser de tener Live Patch permite estas actualizaciones sin tener que hacer reinicio, pide registrar hasta 3 máquinas para este proceso.
        
        snap install [nombre_paquete] #Instala un paquete con el nuevo gestor de paquetes de Canonical, snap.
        snap search [nombre_paquete] #buscar un paquete.
        snap refresh --list #Para ver toda la lista de paquetes.
        snap info [nombre_paquete] #verificar la información de un paquete especifico.




   

