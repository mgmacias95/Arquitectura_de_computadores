#!/bin/bash
#PBS -N ejercicio10_atcgrid
#PBS -q ac 
echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"
cat $PBS_NODEFILE
for ((N=14;N<27;N=N+1))
do
    let M=2**$N

    echo "Version secuencial con tamaño $M:"

    $PBS_O_WORKDIR/SumaVectoresSecuencial $M

    echo "Version con for con tamaño $M:"

    $PBS_O_WORKDIR/SumaVectoresParalelo $M

    echo "Version con sections con tamaño $M:"

    $PBS_O_WORKDIR/SumaVectoresParalelo-sections $M
done
