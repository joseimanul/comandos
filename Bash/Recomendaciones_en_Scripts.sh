#Los scripts deben empezar con # !/bin/bash, para hacer referencia a que es un script de bash, y se rige por sus reglas

#Para el manejo de argumentos:

#Si quiero saber cuantos argumentos estoy recibiendo en un comando, dentro del script, uso la sentencia:
$#
#Si quiero saber cuales son los argumentos textualmente que estoy recibiendo, uso la sentencia:
$*
#Para asignarle a una variable, el contenido de un comando, usar, uso la sentencia:
myVar=$(pwd)

#Para revisar las entradas y las salidas de un script, uso el comando:
bash -x [Nombre_Script]

#Expresiones regulares, para la validacion de expresiones regulares, contamos con algunas funciones que nos entrega bash, que pueden ser combinadas entre si, como las siguientes:

^ Caracter que representa el inicio de la expresión regular.
$ Caracter que representa el final de la expresión regular.
* Caracter que representa cero o más ocurrencias de la expresión
+ Caracter que representa una o más ocurrencias de la expresión.
{n} Representa n veces de una expresión.
[ ] Representa un conjunto de caracteres, por ejemplo: [a-z] representa las letras del abecedario de la a a la z.

#Combinacion de estas validaciones:

#Aqui le estoy diciendo que los valores que puede resibir esta variable, son números del 0 al 9, y que estos números deben estar presentes, la cantidad de 10 veces.
miVar='^[0-9]{10}$'

#Aqui le estoy diciendo que el usuario va a poder elegir entre las cadenas de caracteres mencionadas, o es una, o es la otra.
miVar='^EC|COL|US|VEN$'


#Para recibir un valor del usuario, y guardarlo en una variable, al mismo tiempo que imprimo un mensaje, utilizo el siguiente comando:
read -p "Por favor ingrese un valor" myVariable

#Una forma de limitar la cantidad máxima de caracteres recibida desde teclado, es con el siguiente comando:
read -n5 -p "Por favor ingresa un valor, de 5 caractares como máximo" myVariable 

#Comparaciones De Cadenas Alfanumericas, sirven en estructuras condicionales

#Estructura de un condicional if
if [ $edad -le 18 ]; then #"le" en el condicional, significa lower equals
    echo -e "\n La persona no puede sufragar"
else
    echo -e "\n La persona puede sufragar"
fi


#Estructura condicional con elseif
if [ $edad -le 18 ]; then
    echo "La persona es adolescente"
elif [ $edad -ge 19 ] && [ $edad -le 64 ]; then
    echo "La persona es adulta"
else
    echo "La persona es adulto mayor"
fi

#Operador Verdad (TRUE) si:
cadena1 = cadena2 cadena1 es igual a cadena2
cadena1 != cadena2 cadena1 no es igual a cadena2
cadena1 < cadena2 cadena1 es menor que cadena2
cadena1 > cadena 2 cadena1 es mayor que cadena 2
-n cadena1 cadena1 no es igual al valor nulo (longitud mayorque 0)
-z cadena1 cadena1 tiene un valor nulo (longitud 0)

#Comparacion De Valores Numericos

    #Operador Verdad (TRUE) si:
    x -lt y #x menor que y
    x -le y #x menor o igual que y
    x -eq y #x igual que y
    x -ge y #x mayor o igual que y
    x -gt y #x mayor que y
    x -ne y #x no igual que y

    #Comprobacion De Atributos De Fichero

    #Operador Verdad (TRUE) si:
    -d fichero #fichero existe y es un directorio
    -e fichero #fichero existe
    -f fichero #fichero existe y es un fichero regular (no un directorio, u otro tipo de fichero especial)

    -r fichero #Tienes permiso de lectura en fichero
    -s fichero #fichero existe y no esta vacio
    -w fichero #Tienes permiso de escritura en fichero
    -x fichero #Tienes permiso de ejecucion en fichero (o de busqueda si es un directorio)

    -O fichero #Eres el dueño del fichero
    -G fichero #El grupo del fichero es igual al tuyo.

    fichero1 -nt fichero2 #fichero1 es mas reciente que fichero2
    fichero1 -ot fichero2 #fichero1 es mas antiguo que fichero2


#Sentencia CASE

case $opcion in
    "A") echo -e "\nOperaciÃ³n Guardar Arhivo";;
    "B") echo "OperaciÃ³n Eliminar Archivo";;
    [C-E]) echo "No esta implementada la operaciÃ³n";;
    "*") "OpciÃ³n Incorrecta"
esac    

#Validar la opciÃ³n ingresada
    case $opcion in
        1)
            echo -e "\nInstalar postgres....."
            sleep 3
            ;;
        2) 
            echo -e "\nDesinstalar postgres...."
            sleep 3
            ;;
        3) 
            echo -e "\nSacar respaldo..."
            sleep 3
            ;;
        4) 
            echo -e "\nRestaurar respaldo..."
            sleep 3
            ;;
        5)  
            echo "Salir del Programa"
            exit 0
            ;;
    esac

#Sentencia FOR

echo "Iterar en la Lista de NÃºmeros"
for num in ${arregloNumeros[*]} #En un arreglo estático, es necesario poner el *, para que agarre el arreglo completo
do
    echo "NÃºmero:$num"
done

echo "Iterar en la lista de Cadenas"
for nom in "Marco" "Pedro" "Luis" "Daniela" #Se puede iterar en cadenas sueltas
do
    echo "Nombres:$nom"
done

echo "Iterar en Archivos" #cuando le digo *, va a listar todos los archivos del directorio donde está ubicado
for files in *
do
    echo "Nombre archivo:$files"
done

echo "Iterar utilizando un comando" #Aqui podemos agregar una ruta por ejemplo, y obtener una lista de los archivos de esa ruta, podriamos meter diferentes listas, segun el comando
for fil in $(ls /home/joseimanul/)
do
    echo "Nombre archivo:$fil"
done

echo "Iterar utilizando el formato tradcional"
for ((i=1; i<10; i++))
do
    echo "NÃºmero;$i"
done

#Ciclo WHILE

while [ $numero -ne 10 ] #Mientras el numero sea diferente de 10
do
    echo "Imprimiendo $numero veces"
    numero=$(( numero + 1 ))
done

# "Sentencias break y continue"
for fil in $(ls)
do
    for nombre in {1..4}
    do
        if [ $fil = "10_download.sh" ]; then #"Se encontro el archivo $fil y por eso se termian el bucle interno"
            break;
        elif [[ $fil == 4* ]]; then #"Se encontro el archivo $fil y continua"
            continue;
        else
            echo "Nombre archivo:$fil _ $nombre"
        fi
    done
done

#Para escribir sobre un archivo

echo "Valores escritos con el comando echo" >> texto.txt

#AdiciÃ³n multilÃ­nea
cat <<EOM >>texto.txt
    texto agregado mediante el comando cat
EOM

# ! /bin/bash
# Programa para ejemplificar como se lee en un archivo
# Autor: Marco Toscano Freire - @martosfre

echo "Leer en un archivo"
cat $1

echo -e "\nAlmacenar los valores de un archivo en una variable"
valorCat=`cat $1`
echo "$valorCat"

# Se utiliza la variable IFS (Internal Field Separator) para evitar que los espacios en blanco o las identaciones sean recortadas
echo -e "\nLeer archivos línea por línea utilizando while"
while IFS= read linea
do
    echo "$linea"
done < $1 


# ! /bin/bash
# Programa para ejemplificar las operaciones de un archivo
# Autor: Marco Toscano Freire - @martosfre

echo "Operaciones de un archivo"
mkdir -m 755 backupScripts

echo -e "\nCopiar los scripts del directorio actual al nuevo directorio backupScripts"
cp *.* backupScripts/
ls -la backupScripts/

echo -e "\nMover el directorio backupScripts a otra ubicaciÃ³n: $HOME"
mv backupScripts $HOME


echo -e "\nEliminar los archivos .txt"
rm *.txt


#Crear un archivo dentro de un script 
echo "Elegista la opcion $option y como resultado $result" >> "Jose"$(date +"%Y_%M_%d_%h_%m_%s").log
