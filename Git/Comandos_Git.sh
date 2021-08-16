#Para crear un proyecto git, desde ceros en tu computador o servidor.
git init.

#Para que git registre todos los documentos nuevos en tu proyecto
git add .

#Para que git agregue todos los cambios sobre los documentos registrados en tu proyecto
git commit -m "Mensaje del commit"
    #Para guardar los cambios de git sobre un documento o directorio especifico
    git [carpeta/archivo] -m "Mensaje commit"

#Para instalar git en linux
    #Red hat
    yum -y install git
    #Ubuntu
    apt install git
    #Consultar version de git instalada
    git --version

# Consultar el estado de todos los archivos y carpetas.
git status

#Si por ejemplo hiciste un commit y te llevaste un archivo que no debias llevar, puedes ejecutar el siguiente comando, para devolverlos a un estado anterior, y que asi puedas agregar los archivos correctos al commit
git reset HEAD

#Con el comando anterior, devovlemos los archivos al estado que quedan con el comando git add, a este estado, lo vamos a llamar staged. Con el siguiente comando, vamos a sacar el o los archivos de git, desde el estado del tracked, hasta el estado unstaged.
git rm --cached [nombre_archivo]

#Si cambiamos el argumento del comando git rm, podemos no solo pasar los archivos o directorios, a un estado anterior al del git add (unstaged), sino que borramos los archivos del disco duro.
git rm --force [nombre_archivo]

#El comando git show nos muestra los cambios que han existido sobre un archivo y es muy útil para detectar cuándo se produjeron ciertos cambios, qué se rompió y cómo lo podemos solucionar. Pero podemos ser más detallados.
git show 

#Si queremos ver la diferencia entre una versión y otra, no necesariamente todos los cambios desde la creación del archivo, podemos usar el comando git diff commitA commitB.
git diff Id_commitA Id_commitB

#Recuerda que puedes obtener el ID de tus commits con el comando git log.
git log

#Para ir hacia un commit especifico, donde tengamos X versión  de nuestro código, usamos el comando 
git checkout Id_commit

#Si queremos no solo regresar a consultar un commit anterior, sino que seguir trabajando desde ahí, podemos usar los siguiente comandos:
    #Con este comando volvemos a esa version de commit, pero conservamos los cambios del ultimo commit en el área de staged, de tal forma que con un git commit, podrias regresar a los cambios del último commit. 
    git reset --soft Id_commit
    #Con este comando volvemos a la version de commit indicada, pero borrando todo lo que hicimos hacia adelante de este commit.
    git reset --hard Id_commit

#Para traer un repositorio público a privado a tu servidor, usas el siguiente comando, la diferencia entre el público y el privado, es que uno te pide una clave, o tu usuario tiene que estar autorizado en ese proyecto, y el otro no te pide nada.
git clone [url_del_servidor_remoto]

# Primero: Guardar la URL del repositorio de GitHub con el nombre de origin
git remote add origin [url_del_servidor_remoto] 
# Segundo: Verificar que la URL se haya guardado correctamente:
git remote
git remote -v
# Tercero: Traer la versión del repositorio remoto y hacer merge para crear un commit con los archivos de ambas partes. Podemos usar git fetch y git merge o solo el git pull con el flag --allow-unrelated-histories:
git pull origin master --allow-unrelated-histories
#Con el siguiente comando, actualizamos nuestro repositorio local, con la última version del repositorio remoto en que estamos trabajando, sobre las ramas en las que estamos trbajando.

git pull [alias_servidor_remoto] [rama]
    #Aqui traemos desde el servidor que configuramos como el origen de nuestro repositorio, hacia la rama principal, master
    git pull origin master

#Con este comando enviamos nuestros cambios hacia el servidor remoto destino.
git push [alias_servidor_remoto] [rama]
    #Aqui enviamos hacia el servidor que configuramos como el origen de nuestro repositorio, hacia la rama principal, master
    git push origin master

#git fetch: Lo usamos para traer actualizaciones del servidor remoto y guardarlas en nuestro repositorio local (en caso de que hayan, por supuesto).
git fetch

#git merge: También usamos el comando git fetch con servidores remotos. Lo necesitamos para combinar los últimos cambios del servidor remoto y nuestro directorio de trabajo.
git merge

#Para crear una nueva rama, desde donde vamos a hacer pruebas o desarrollos en paralelo, podemos usar los comandos 
git branch [nombre_rama] 

#Este comando no solo crea la rama, sino que me lleva hacia ella de una vez.
git checkout -b [nombre_rama] 

#MERGE
    #El comando git merge nos permite crear un nuevo commit con la combinación de dos ramas (la rama donde nos encontramos cuando ejecutamos el comando y la rama que indiquemos después del comando).

    # Crear un nuevo commit en la rama master combinando los cambios de la rama cabecera:
    git checkout master
    git merge cabecera

    # Crear un nuevo commit en la rama cabecera combinando los cambios de cualquier otra rama:
    git checkout cabecera
    git merge cualquier-otra-rama
    #Asombroso, ¿verdad? Es como si Git tuviera super poderes para saber qué cambios queremos conservar de una rama y qué otros de la otra. El problema es que no siempre puede adivinar, sobretodo en algunos casos donde dos ramas tienen actualizaciones diferentes en ciertas líneas en los archivos. Esto lo conocemos como un conflicto y aprenderemos a solucionarlos en la siguiente clase.

#Configura tus llaves SSH en local
    #Primer paso: Generar tus llaves SSH. Recuerda que es muy buena idea proteger tu llave privada con una contraseña.
    ssh-keygen -t rsa -b 4096 -C "tu@email.com"
    #Segundo paso: Terminar de configurar nuestro sistema.
    #En Windows y Linux: Encender el "servidor" de llaves SSH de tu computadora:
    eval $(ssh-agent -s)
    # Añadir tu llave SSH a este "servidor":
    ssh-add ruta-donde-guardaste-tu-llave-privada
        ssh-add /home/[usuario]/.ssh
    #El contenido de tu llave publica, debe ser agregado en github, en esa url, una vez estes logueado a tu cuenta
    https://github.com/settings/keys
    #Una vez completamos el paso anterior, ejecutamos el siguiente comando
    git remote set-url origin url-ssh-del-repositorio-en-github
        git remote set-url origin git@github.com:joseimanul/prueba.git

#TAGS
    #Los tags o etiquetas nos permiten asignar versiones a los commits con cambios más importantes o significativos de nuestro proyecto.
    # Comandos para trabajar con etiquetas:

    # Crear un nuevo tag y asignarlo a un commit: 
    git tag -a nombre-del-tag id-del-commit.
    # Borrar un tag en el repositorio local: 
    git tag -d nombre-del-tag.
    # Listar los tags de nuestro repositorio local: 
    git tag o git show-ref --tags.
    # Publicar un tag en el repositorio remoto: 
    git push origin --tags.
    # Borrar un tag del repositorio remoto: 
    git tag -d nombre-del-tag y git push origin :refs/tags/nombre-del-tag.

#Ver ramas graficamente, Recuerda que podemos ver gráficamente nuestro entorno y flujo de trabajo local con Git usando el comando 
gitk

# Cambiamos a la rama que queremos traer los cambios
git checkout experiment
# Aplicamos rebase para traer los cambios de la rama que queremos 
git rebase master

#Git Stash 
    #Guardar cambios en memoria y recuperarlos después cuando necesitamos regresar en el tiempo porque borramos alguna línea de código pero no queremos pasarnos a otra rama porque nos daría un error ya que debemos pasar ese “mal cambio” que hicimos a stage, podemos usar git stash para regresar el cambio anterior que hicimos.
    git stash
    #git stash es típico cuando estamos cambios que no merecen una rama o no merecen un rebase si no simplemente estamos probando algo y luego quieres volver rápidamente a tu versión anterior la cual es la correcta.

#Git Clean: 
    #limpiar tu proyecto de archivos no deseados s veces creamos archivos cuando estamos realizando nuestro proyecto que realmente no forman parte de nuestro directorio de trabajo, que no se deberían agregar y lo sabemos.
    #Para saber qué archivos vamos a borrar tecleamos 
    git clean --dry-run
    #Para borrar todos los archivos listados (que no son carpetas) tecleamos 
    git clean -f

#Git cherry-pick: 
    #traer commits viejos al head de un branch, existe un mundo alternativo en el cual vamos avanzando en una rama pero necesitamos en master uno de esos avances de la rama, para eso utilizamos el comando 
    git cherry-pick IDCommit
    #cherry-pick es una mala práctica porque significa que estamos reconstruyendo la historia, usa cherry-pick con sabiduría. Si no sabes lo que estás haciendo ten mucho cuidado.

#git amend
    # Reconstruir commits en Git con amend, a veces hacemos un commit, pero resulta que no queríamos mandarlo porque faltaba algo más. Utilizamos 
    git commit --amend
    # amend en inglés es remendar y lo que hará es que los cambios que hicimos nos los agregará al commit anterior.

#Git Reset y Reflog: úsese en caso de emergencia
    # ¿Qué pasa cuando todo se rompe y no sabemos qué está pasando? Con git reset HashDelHEAD nos devolveremos al estado en que el proyecto funcionaba.
    git reset --soft HashDelHEAD #te mantiene lo que tengas en staging ahí.
    git reset --hard HashDelHEAD #resetea absolutamente todo incluyendo lo que tengas en staging.
    #git reset es una mala práctica, no deberías usarlo en ningún momento; debe ser nuestro último recurso.

#Git grep 
    # Buscar en archivos y commits de Git con Grep y log. A medida que nuestro proyecto se hace grande vamos a querer buscar ciertas cosas.
    # Por ejemplo: ¿cuántas veces en nuestro proyecto utilizamos la palabra color? Para buscar utilizamos el comando git grep color y nos buscará en todo el proyecto los archivos en donde está la palabra color.
    # Con git grep -n color nos saldrá un output el cual nos dirá en qué línea está lo que estamos buscando.
    git grep -n color
    # Con git grep -c color nos saldrá un output el cual nos dirá cuántas veces se repite esa palabra y en qué archivo.
    git grep -c color
    # Si queremos buscar cuántas veces utilizamos un atributo de HTML lo hacemos con git grep -c "<p>".
    git grep -c "<p>"

#Comandos
    git shortlog -sn #muestra cuantos commit han hecho cada miembros del equipo.
    git shortlog -sn --all #muestra cuantos commit han hecho cada miembros del equipo hasta los que han sido eliminado
    git shortlog -sn --all --no-merge #muestra cuantos commit han hecho cada miembros quitando los eliminados sin los merges
    git blame ARCHIVO #muestra quien hizo cada cosa linea por linea
    git COMANDO --help #muestra como funciona el comando.
    git blame ARCHIVO -Llinea_inicial,linea_final #muestra quien hizo cada cosa linea por linea indicándole desde que linea ver ejemplo -L35,50
    git branch -r #se muestran todas las ramas remotas
    git branch -a #se muestran todas las ramas tanto locales como remotas