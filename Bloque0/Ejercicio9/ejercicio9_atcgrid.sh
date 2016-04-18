#!/bin/bash
#PBS -N ejercicio9_atcgrid
#PBS -q ac 
echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"
cat $PBS_NODEFILE
for ((N=16;N<27;N=N+1))
do
    let M=2**$N

    echo "Vectores locales con tamaño $M:"

    $PBS_O_WORKDIR/sumavectoreslocales $M

    echo "Vectores globales con tamaño $M:"

    $PBS_O_WORKDIR/sumavectoresglobales $M

    echo "Vectores dinamicos con tamaño $M:"

    $PBS_O_WORKDIR/sumavectoresdinamicos $M
done
