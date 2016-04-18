#!/bin/bash

export OMP_DYNAMIC=FALSE

echo "Tiempo secuencial con 100"
./pmmsec 100

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 100"
./pmmomp 100

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 100"
./pmmomp 100

echo "--------------------------------------------------"

echo "Tiempo secuencial con 500"
./pmmsec 500

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 500"
./pmmomp 500

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 500"
./pmmomp 500

echo "--------------------------------------------------"

echo "Tiempo secuencial con 1000"
./pmmsec 1000

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 1000"
./pmmomp 1000

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 1000"
./pmmomp 1000

echo "--------------------------------------------------"

echo "Tiempo secuencial con 1500"
./pmmsec 1500

export OMP_NUM_THREADS=2
echo "Tiempo con dos threads con 1500"
./pmmomp 1500

export OMP_NUM_THREADS=4
echo "Tiempo con cuatro threads con 1500"
./pmmomp 1500

echo "--------------------------------------------------"