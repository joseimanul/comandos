#Con este comando, descargo y corro una imagen desde dockerhub, llamada "in28min/hello-world-python", con la version 0.0.1.RELEASE, y la corro desde el puerto 5000 de mi computador, hacia el puerto 5000 del contenedor. Como nota, el contenedor creado a partir de esta imagen, no se queda ejecutando en background, tan pronto me salgo de la ejecución del proceso, el contenedor muere
docker run -p 5000:5000 in28min/hello-world-python:0.0.1.RELEASE
    docker run -p 5000:5000 in28min/hello-world-java:0.0.1.RELEASE
    docker run -p 5000:5000 in28min/hello-world-nodejs:0.0.1.RELEASE

#Nota: en teoría, el comando "docker container run" y "docker run", hacen lo mismo.

    #Con este comando, estoy ejecutando el contenedor como "deatached", lo que permite es que mi contenedor pueda vivir en background, sin que tenga que dejar el proceso abierto en consola o terminal
    docker run -d -p 5000:5000 in28min/hello-world-nodejs:0.0.1.RELEASE

    #Con el parametro "-m", puedo limitar el uso de memoria RAM de un contenedor, por ejemplo, al indicarle "- 512m", le estoy diciendo que el limite de RAM para ese contenedor, será de 512 mega bytes:
    docker run -d -p -m 512m 5000:5000 in28min/hello-world-nodejs:0.0.1.RELEASE

    #Con el parametro "--cpu-quota", podemos limitar el uso de CPU sobre nuestro, por ejemplo "--cpu-quota=5000", tendrá la mitad de cores, y por tanto la mitad porcentualmente.
    docker run -d -p -m 512m --cpu-quota=5000 5000:5000 in28min/hello-world-nodejs:0.0.1.RELEASE
    
#Cuando se crea un contenedor, este se crea con un identificador único, sobre este identificador único, puedo hacer la consulta de los logs, con el siguiente comando:
docker logs "identificador_contenedor"
    docker logs b99082e589380acf10cf7527e514d9a2229df20ac106013df78a3b8b293ba5f2
    #Dejo que los logs se queden corriendo
    docker logs -f b99082e589380acf10cf7527e514d9a2229df20ac106013df78a3b8b293ba5f2

#Con este comando, puedo ver las imágenes locales que tengo en el pc
docker images
    #Con este comando, puedes ver el detalle de una imagen, por medio de su "image id"
    docker image inspect "image_id"
    docker image inspect d1165f221234
    #con este comando puedo borrar imagenes de mi entorno local
        #Nota: no puedes remover una imagen, si hay un contenedor corriendo, que fuera creado a partir de esa imagen, primero tienes que matar el contenedor
    docker image remove "image_id || repository:tag"


#Con este comando puedo ver los contenedores que están corriendo
docker container ls
    #Con este comando puedo ver todos los contenedores, incluyendo los que murieron o se encuentran abajo
    docker container ls -a

#Con este comando puedo detener un contenedor
docker container stop "identificador_contenedor"
    docker container stop b99082e589380acf10cf7527e514d9a2229df20ac106013df78a3b8b293ba5f2

#Con este comando, elimino o remuevo un contenedor
    #Nota: para eliminar un contenedor, primero debo detenerlo, tiene que estar en estado "Exited"
docker container rm "identificador_contenedor"

#Con este comando, "mato" a un contendor, sin necesidad de detenerlo
docker container kill "identificador_contenedor"

#Con este comando, elimino o remuevo, todos los contenedores que están detenidos, o que ya no están arriba
docker container prune
    #Con este comando, además de eliminar todos los contenedores que están que ya no están arriba, borramos todas las imagenes que no tengan un contenedor asociado
    docker container prune -a

#Con este comando puedo saber el espacio en disco, que está ocupando Docker, incluidos las imagenes, los contenedores, volumenes locales y cache
docker system df

#Con este comando, podemos ver un "log", de los eventos relacionados con docker, si matamos un contenedor, si creamos uno, si se detiene, entre otros
docker system events

#Con este comando puedo saber algunos datos de un contenedor, como el porcentaje de CPU que está consumiendo, memoria RAM, su id y su nombre
docker stats "identificador_contenedor"



