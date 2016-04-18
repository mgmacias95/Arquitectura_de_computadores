#!/bin/bash
#Se asigna al trabajo el nombre SumaVectoresC_vlocales
#PBS -N script_cpu
#Se asigna al trabajo la cola ac
#PBS -q ac
#Se imprime información del trabajo usando variables del entorno PBS
echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificado por usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"
cat $PBS_NODEFILE
#Mostramos el fichero /proc/cpuinfo
cat /proc/cpuinfo
