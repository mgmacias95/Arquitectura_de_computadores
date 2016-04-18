#!/bin/bash
for ((N=400;N<1200;N=N+200))
do
    echo "Version secuencial con tamaño $N:"

    ./pmvs $N

    echo "Version a con tamaño $N:"

    ./pmv-openmp1 $N

    echo "Version b con tamaño $N:"

    ./pmv-openmp2 $N

    echo "Version reduction con tamaño $N:"

    ./pmv-openmp3 $N
done
