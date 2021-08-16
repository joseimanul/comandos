#BASICOS
	pwd #directorio actual.
	cd #Change Directory {nombre carpeta}: ingresar a esa carpeta.
	clear #sirve para limpiar la pantalla
	cd .. #regresar a la carpeta anterior
	ls #listar los elementos que hay en la carpeta actual
	cat {nombre archivo} #me muestra el contenido de un archivo
	grep {cadena a buscar} {archivo} #busca una cadena en un archivo.
	grep -lir {cadena a buscar} {archivo} #busca una cadena en un archivo, sin tener en cuenta el case-sensitive.
	ctrl + r #buscar comandos ejecutados
	history #historial de comandos
	cat /etc/*-release #version de linux
	cat /etc/passwd #listar usuarios
	which Nombre_Programa

	sqlplus nombre_user@(service_name)|(sid de la base de datos, dependiendo del tipo de conexion)
	sqlplus sys/manager@SFLA0800 as sysdba #ingresar con el usuario SYS como SYSDBA
	orapwd file=orapwSFLA0800 entries=10 force=y password=manager #fijar un password de manera obligatorio en oracle

#¿cómo saber donde tengo mi java, u otros programas dado el caso?
	which java
	
#Para la version de Linux
	cat /etc/*-release


	alter system set sec_case_sensitive_logon=FALSE;

#como setear variable de entorno java
	/usr/sbin/alternatives --config java #con este comando voy a obtener la ruta de java para la variable de entorno
	export JAVA_HOME= #con este comando voy a setear en el usuario con el que ejecuto el comando -- COPIAR TODA LA RUTA HASTA ANTES DE JRE


	curl -G -X -s -w "%{http_code}" GET http://10.60.70.15:8080

#Este comando sirve para ejecutar script de sql, y dejar un registro del mismo en un archivo llamado nohup.out
	nohup sqlplus USERNAME/password@DBNAME @test.sql &


SFBZ0800/BPSFV8@A3B80I01

sqlplus -s -l SFBZ0800/BPSFV8@A3Q80I01 <<EOF > Log_Semilla_A3_SAO515632_SO_R20_V01.log
set linesize 2000;
set wrap off;
SELECT count(*) FROM dba_objects WHERE status = 'INVALID' AND owner = 'SFBZ0800'; 	
@./aplicaSAO515632.sql;	
SELECT count(*) FROM dba_objects WHERE status = 'INVALID' AND owner = 'SFBZ0800'; 	
exit;
EOF


sqlplus -s -l SFBZ0800/BPSFV8@A3B80I02 <<EOF > Log_PAS_A3_SAO515705_SO_R20_V01.log
set linesize 2000;
set wrap off;
SELECT count(*) FROM dba_objects WHERE status = 'INVALID' AND owner = 'SFBZ0800'; 	
@./CC_BOSaleWaterLatam.pkg;	
SELECT count(*) FROM dba_objects WHERE status = 'INVALID' AND owner = 'SFBZ0800'; 	
exit;
EOF



#NodeJS
# iniciar con usuario nodejs
	cd /home/nodejs/SFBZ0800/NotificationsPopUp  #(ruta proyecto)
	pm2 start openintl-nodejs.config.js #(archivo .config.js que se encuentra en la carpeta del proyecto)

#Revisar el log o un archivo en que se este modificando en tiempo real, con el comando tail -f
	iniciar con usuario tomcat
	ejecutar: sudo systemctl start tomcat
	cd $CATALINA_HOME/logs/
	tail -f catalina.out 
 
#Con este comando obtengo el almacenamiento (storage) de una maquina, si cambio el $2 por $3, me da la memoria RAM
	cat /proc/cpuinfo
	cat /proc/meminfo | grep "MemTotal"
	df -lP | awk '{total+=$2} END {printf "%d G\n", total/2^20 + 0.5}'
	df -h #espacio de los discos o volumenes en un servidor

#Traer un archivo desde un servidor remoto
	scp username@server_ip:/path_to_remote_directory local_machine/path_to_the_file 
# aqui estoy extrayendo el archivo tomcatAWS.tar.gz, en la ruta /opt/, en la maquina con ip pública 18.204.120.185, con el usuario root, y lo estoy dejando en mi maquina, en el directorio /opt
	scp root@18.204.120.185:/opt/tomcatAWS.tar.gz /opt

#Cuando modifico el archivo sshd.config, y quiero ver reflejados los cambios, ejecuto el siguiente comando:
	service sshd restart

#Sincronizar discos: aqui le estoy diciendo que me sincronice el disco o volumen llamado "/oracle" de la maquina 34.239.79.255 a mi maquina, en disco llamado "/oracle"
	nohup rsync -avzhu -progress -e ssh root@34.239.79.255:/oracle/ /oracle & 
	34.196.173.211:/path_archivo_remoto path_archivo_local

#Comprimir
	tar -czvf empaquetado.tar.gz /carpeta/a/empaquetar/
	tar -czvf tomcatAWS.tar.gz tomcat
#Descomprimir
	tar -xzvf archivo.tar.gz
	tar -xzvf AWSapache-karaf-4.2.4.tar.gz

#usuario y password de OHS en AWS
open
Smartflex.   
user: hefesol734@emailhost99.com and pass: Open2020*

#para ver los usuarios del sistema
cat /etc/passwd 

# CREAR UNA RELACION DE CONFIANZA ENTRE DOS USUARIOS DE MAQUINAS DIFERENTES DESDE CERO:

# 1.	En el home del usuario origen me voy a la carpeta ".ssh", sino existe la carpeta, la creo
	mkdir .ssh

# 2.	una vez dentro de la carpeta, muevo los archivos id_rsa  id_rsa.pub, en caso de que existan, a una carpeta como back-up, para mover ambos archivos al mismo tiempo puedo usar el comando 
	mv id_rsa* my_carpeta_back-up

# 3.	Ahora ejecuto el comando para generar las llaves ssh, en caso de que las que existan no me sirvan, si me sirven utilizo las que están
	ssh-keygen
	#para generar los archivos 'id_rsa  id_rsa.pub', aqui debo dar enter a todo, sino quiero generar contraseñas sobre estos archivos

# 4.	Ahora en el servidor y usuario destino, ejecuto el paso número 1, y me aseguro que la carpeta tenga los siguientes permisos:
	chmod 700 -R .ssh/
	cd .ssh/

# 5.	Dentro de la carpeta .ssh del servidor destino, creo un archivo en blanco llamado authorized_keys y le doy los siguientes permisos:
	>authorized_keys
	chmod 600 authorized_keys
	
# 6.	Ahora sobre el home del servidor origen, ejecuto el siguiente comando:
		cat .ssh/id_rsa.pub | ssh destino_user@destino_server 'cat >> .ssh/authorized_keys' 
		cat .ssh/id_rsa.pub | ssh nodejs@172.20.32.13 'cat >> .ssh/authorized_keys'
		cat .ssh/id_rsa.pub | ssh karaf@10.60.70.125 'cat >> .ssh/authorized_keys'		
		#Al ejecutar este comando me van a pedir la contraseña del usuario del servidor destino, despues me va a preguntar si estoy seguro, le digo que 'yes'.

# 7.	Ahora para verificar que efectivamente se creo la relacion de confianza, puedo ejecutar el comando 
	ssh tomcat@10.60.70.86 #y este me debe de conectar a la maquina destino.
		ssh -v tomcat@10.60.70.86 #con este comando puedo ver como es la conexión paso a paso, puedo colocar hasta cuatro veces, la letra "v", para tener mayor detalle ssh -vvvv tomcat@10.60.70.86


#Bajar una base de datos sino tienes las credenciales del sysdba
	#1.	Primero te conectas con root, luego pasas al usuario dueño de la base de datos, sino sabes cual es el usuario, puedes consultar todos los usuarios con 
	cat /etc/passwd
	#2.	Dentro de ese listado buscas los usuarios oracle y luego ejecutas el comando
	ps -fea | grep pmon #con este comando puedes saber que usuario subio la base de datos
	#3.	Ahora te pasas a ese usuario desde root, mediante el siguiente comando
	su - user # por ejemplo puede ser 'su - oracle18'
	#4.	luego con este usuario puedes conectarte como sysdba sin necesidad de la clave, con el siguiente comando:
	sqlplus
	#luego te va a pregutar con que usuario te quieres logear y le das:
	/as sysdba #y con eso ya quedas dentro de la base de datos como sysdba
	#5.	Luego ejecutas el siguiente comando para bajar la base de datos
	shutdown immediate 
	# y esperas a que te salgan los siguientes mensajes: Base de datos cerrada. Base de datos desmontada. Instancia ORACLE cerrada.
	#6. Si quieres subir la base de datos, te vuelves a conectar como sysdba y ejecutas el siguiente comando y esperas
	startup



#Agregar a un usuario al grupo sudo en redhat
	#primero crear usario
	useradd karaf 
	#aqui le damos al usuario permisos de sudo
	usermod -aG wheel karaf 
	#aqui le asignamos una contraseña
	passwd karaf 

#Como se arman las urls en OSF, si me conecto por HTTP, la direccion se compone por la ip:puerto/path_del_webapps_tomcat/SACME/index.html#login, por ejemplo http://10.60.70.35:8080/OSF/SACME/index.html#login

#change hostname RedHat
	hostnamectl
	hostnamectl set-hostname ###newhostname
	hostnamectl set-hostname vmusasfbp0800db
	vi /etc/hosts
	Ip ###newhostname

#Ejecutar un script sql desde linea de comando, dejando una traza
	nohup sqlplus SFBENUSA/BPSFV8@SFBP0800 @file.sql
	nohup sqlplus OPEN/O182D0350C5F982967E501342EB048@SFBE0800 @SyncWebSites_V2.sql

#Pasos para subir el listener, hacer esto si al momento de conectar a la base de datos, si te dice que no hay listener o algo asi
	lsnrctl status #Con este comando te va a dar el status, te va a decir si hay o no hay listener
	lsnrctl stop
#Ahora te vas al oracle home, para saber donde esta ubicado, consultas la variable de entorno ORACLE_HOME, y le das el siguiente comando
	echo $ORACLE_HOME
#Sino aparece seteado, le das el comando '. .profile'
	. .profile
	cd $ORACLE_HOME
#Una vez dentro vas a la ruta network/admin y consultas el archivo listener.ora
	cd network/admin
#Verificas que el listener este abajo con el comando lsnrctl status
	lsnrctl status
#Sino esta abajo lo bajas con el comando lsnrctl stop
	lsnrctl stop
	vi listener.ora #Dentro de este archivo modificas la direccion ip por 'localhost'
#Una vez lo cambias, vuelves a subir el listener con el comando 
	lsnrctl start

#Si hay un error al momento de construir el osck y el error es por mven ir a la siguiente ruta
	cd apache-karaf-4.2.4/etc
#y modificar el archivo org.ops4j.pax.url.mvn.cfg
	vi org.ops4j.pax.url.mvn.cfg #Dentro del archivo modificar la linea 'http://repo1.maven.org/maven2@id=central', agregando una 's' al http 'https://repo1.maven.org/maven2@id=central'

#Dentro de los procedimientos a hacer ucando acutalizo un ambiente es resetear todas las claves, eso lo hago mediante dos scripts, esos scripts se llaman 'Actualizar-DS' y 'CAMBIA_CLAVE_APACHEDS', este script cambia las claves de todos los usuarios del directorio activo de apacheds, asignando como clave, el nombre del mismo usuario en mayuscula

#procesos a cerrar al momento de bajar una base de datos, para que baje mas rapido
	ps -fea | grep os.ge*
	ps -fea | grep "LOCAL=NO"
#Dar kill -9 a los procesos que resulten del ps
#directorio donde se encuentran las carpetas web, en el OHS ubicado en oracle-cloud
	cd /oracle/app/oracle11/Middleware/Oracle_WT1/instances/instance1/config/OHS/ohs1/htdocs

#Para sacar trazas de oracle
tkprof SFPA0708_ora_1508058.trc output_traza_juan.txt explain=SFAA0800/ClouD2020###@TESTHA.OSF1 table=SFAA0800.ge_explanin_plan sys=no sort=exeela, fchela, prsela
tkprof OSF1_ora_45698.trc output_traza_juan.txt explain=SFAA0800/ClouD2020###@TESTHA.OSF1 table=SFAA0800.ge_explanin_plan sys=no sort=exeela, fchela, prsela

#FIREWALL
	systemctl status firewalld
	firewall-cmd --state

[06/08 10:55 a.m.] Saul A. Trujillo D.
    netstat -tulpn | grep LISTEN


#Detener firewalld
	systemctl stop firewalld
	systemctl start firewalld

#iniciar firewalld
	service firewalld start
	systemctl start firewalld
	firewall-cmd --reload

	firewall-cmd --get-active-zones

	firewall-cmd --get-zones

	firewall-cmd --set-default-zone=home

	firewall-cmd --get-services
	firewall-cmd --permanent --zone=public --add-service=http

#listar los puertos de una zona 
	firewall-cmd --zone=public --list-all

#Adicionar un puerto
	firewall-cmd --permanent --zone=public --add-port=8080/tcp
	firewall-cmd --permanent --zone=public --add-port=2048/udp

#Remover un puerto
	firewall-cmd --zone=public --remove-port=1521/tcp

##This information is stored in the /etc/firewalld/firewalld.conf file.

##Crear nueva zona
	firewall-cmd --permanent --new-zone=nuevazona

#https://www.tecmint.com/firewalld-rules-for-centos-7/
#https://www.certdepot.net/rhel7-get-started-firewalld/

### Cambiar a iptables
https://www.certdepot.net/rhel7-disable-firewalld-use-iptables/
https://access.redhat.com/solutions/653393

#Información a reemplazar en documento por confirmar, para que cada vez que se inicie el servidor, quede montado el file system shareado
	10.0.3.4:/ActiveMQFS /mnt/ActiveMQFS nfs rw,bg,hard,timeo=600,nfsvers=3 0 0

#Información a reemplazar en el activemq de cada maquina, para garantizar al alta disponibilidad
	#/mnt/ActiveMQFS/OSFTESTHA/OSCK/kahadb" schedulerSupport="true"


#CREAR CERTIFICADOS A PARTIR DE UN ARCHIVO .JKS, HACER CON USUARIO ROOT

#RUTA EN PORTAL
	cd /opt/tomcat/conf
	keytool -importkeystore -srckeystore osf-utha-port02_cs_city_fcgov_com.jks  -destkeystore osf-utha-port02_cs_city_fcgov_com.p12 -deststoretype PKCS12 -srcalias server
	Password: lentil28Dabbing
 
	openssl pkcs12 -in osf-utha-port02_cs_city_fcgov_com.p12 -nodes -out osf-utha-port02_cs_city_fcgov_com.key -nocerts 
	Password: lentil28Dabbing
 
	openssl pkcs12 -in osf-utha-port02_cs_city_fcgov_com.p12 -clcerts -out osf-utha-port02_cs_city_fcgov_com.cer -nokeys 
	Password: lentil28Dabbing
  
	openssl pkcs12 -in osf-utha-port02_cs_city_fcgov_com.p12 -cacerts -out osf-utha-port02_cs_city_fcgov_com-CA.cer -nokeys 
	Password: lentil28Dabbing


keytool -import -alias certificado-dash -noprompt -storepass changeit -keystore $JAVA_HOME/lib/security/cacerts -file certificado-dash.cer

(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL = TCP)(Host = 172.20.32.12)(Port = 1521)))(CONNECT_DATA=(SERVICE_NAME = A3B80I01))

----------------------
redis-cli
127.0.0.1:6379> CONFIG SET protected-mode no
OK

/mnt/OSFDB_FS/Backups/OSF_iad15f/logs

App server 309 maquina docker
cd /data/docker/apps/smf/appserver_SFBG0708
./init.sh
docker-compose start
docker-compose ps 

# SINCORNIZAR LOS archivelog mediante un crosscheck
	su - oracle
	rman target /
	list backup summary;
	crosscheck archivelog all;
	backup device type 'SBT_TAPE' archivelog all delete all input;
	backup device type 'DISK' archivelog all delete all input;




10.60.70.32

rpm -qa

Administrator / Op3n4st3r1x30

H3L1o-re35ES+SuN

H5lLa-Ree*6Ejd+Moon

The “.jar” files contained in the extension have to be replaced in the following server path: 

$ORACLE_HOME/javavm/lib/security 

If there are links in the path, the files have to be updated in the actual path that the links point to. For example: 

$ORACLE_HOME/javavm/jdk/jdk8/lib/security 



mkdir CA
cd CA/

openssl genrsa -out certificadoaaapruebas.key 2048 

openssl req -new -key certificadoaaapruebas.key -out certificadoaaapruebasCA.cer 
CO
VALLE
CALI
OPEN SYSTEMS
OPERACIONES		
#IP DEL SERVIDOR
ENTER
ENTER
ENTER



openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 975 -notext -md sha256 -in intermediate/csr/certificadoaaapruebasCA.cer -out intermediate/certs/certificadoaaapruebas.cer 
Cloud2020***
y
y

chmod 444 intermediate/certs/certificadoaaapruebas.cer

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/certificadoaaapruebas.cer 