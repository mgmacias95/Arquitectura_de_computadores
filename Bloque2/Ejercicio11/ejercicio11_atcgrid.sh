#!/bin/bash
#PBS -N ejercicio11_atcgrid
#PBS -q ac 
echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"
cat $PBS_NODEFILE
for ((N=400;N<1200;N=N+200))
do
    echo "Version secuencial con tamaño $N:"

    $PBS_O_WORKDIR/pmvs $N

    echo "Version a con tamaño $N:"

    $PBS_O_WORKDIR/pmv-openmp1 $N

    echo "Version b con tamaño $N:"

    $PBS_O_WORKDIR/pmv-openmp2 $N

    echo "Version reduction con tamaño $N:"

    $PBS_O_WORKDIR/pmv-openmp3 $N
done
