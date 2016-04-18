#!/bin/bash

#PBS -N ej7_atcgrid
#PBS -q ac 
echo "Id$PBS_O_WORKDIR usuario del trabajo: $PBS_O_LOGNAME"
echo "Id$PBS_O_WORKDIR del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"
cat $PBS_NODEFILE

export OMP_SCHEDULE="static"
echo "static y chunk por defecto"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="static,2"
echo "static y chunk 2"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="static,32"
echo "static y chunk 32"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="static,64"
echo "static y chunk 64"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="static,1024"
echo "static y chunk 1024"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="dynamic"
echo "dynamic y chunk por defecto"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="dynamic,2"
echo "dynamic y chunk 2"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="dynamic,32"
echo "dynamic y chunk 32"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="dynamic,64"
echo "dynamic y chunk 64"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="dynamic,1024"
echo "dynamic y chunk 1024"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="guided"
echo "guided y chunk por defecto"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="guided,2"
echo "guided y chunk 2"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="guided,32"
echo "guided y chunk 32"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="guided,64"
echo "guided y chunk 64"
$PBS_O_WORKDIR/pmtvomp 4096

export OMP_SCHEDULE="guided,1024"
echo "guided y chunk 1024"
$PBS_O_WORKDIR/pmtvomp 4096
