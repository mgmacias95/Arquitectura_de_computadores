#!/bin/bash

#PBS -N ej_10_atcgrid
#PBS -q ac 
echo "Id$PBS_O_WORKDIR usuario del trabajo: $PBS_O_LOGNAME"
echo "Id$PBS_O_WORKDIR del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"
cat $PBS_NODEFILE

export OMP_DYNAMIC=FALSE

echo "Tiempo secuencial con 100"
$PBS_O_WORKDIR/pmmsec 100

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 100"
$PBS_O_WORKDIR/pmmomp 100

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 100"
$PBS_O_WORKDIR/pmmomp 100

export OMP_NUM_THREADS=8
echo "Tiempo con ocho threads con 100"
$PBS_O_WORKDIR/pmmomp 100

export OMP_NUM_THREADS=12
echo "Tiempo con doce threads con 100"
$PBS_O_WORKDIR/pmmomp 100

echo "--------------------------------------------------"

echo "Tiempo secuencial con 500"
$PBS_O_WORKDIR/pmmsec 500

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 500"
$PBS_O_WORKDIR/pmmomp 500

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 500"
$PBS_O_WORKDIR/pmmomp 500

export OMP_NUM_THREADS=8
echo "Tiempo con ocho threads con 500"
$PBS_O_WORKDIR/pmmomp 500

export OMP_NUM_THREADS=12
echo "Tiempo con doce threads con 500"
$PBS_O_WORKDIR/pmmomp 500

echo "--------------------------------------------------"

echo "Tiempo secuencial con 1000"
$PBS_O_WORKDIR/pmmsec 1000

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 1000"
$PBS_O_WORKDIR/pmmomp 1000

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 1000"
$PBS_O_WORKDIR/pmmomp 1000

export OMP_NUM_THREADS=8
echo "Tiempo con ocho threads con 1000"
$PBS_O_WORKDIR/pmmomp 1000

export OMP_NUM_THREADS=12
echo "Tiempo con doce threads con 1000"
$PBS_O_WORKDIR/pmmomp 1000

echo "--------------------------------------------------"

echo "Tiempo secuencial con 1500"
$PBS_O_WORKDIR/pmmsec 1500

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 1500"
$PBS_O_WORKDIR/pmmomp 1500

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 1500"
$PBS_O_WORKDIR/pmmomp 1500

export OMP_NUM_THREADS=8
echo "Tiempo con ocho threads con 1500"
$PBS_O_WORKDIR/pmmomp 1500

export OMP_NUM_THREADS=12
echo "Tiempo con doce threads con 1500"
$PBS_O_WORKDIR/pmmomp 1500

echo "--------------------------------------------------"