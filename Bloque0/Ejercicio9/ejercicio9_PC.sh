#!/bin/bash
for ((N=16;N<27;N=N+1))
do
    let M=2**$N

    echo "Vectores locales con tamaño $M:"

    ./sumavectoreslocales $M

    echo "Vectores globales con tamaño $M:"

    ./sumavectoresglobales $M

    echo "Vectores dinamicos con tamaño $M:"

    ./sumavectoresdinamicos $M
done
