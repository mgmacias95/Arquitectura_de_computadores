#!/bin/bash
for ((N=14;N<27;N=N+1))
do
    let M=2**$N

    echo "Version secuencial con tamaño $M:"

    ./SumaVectoresSecuencial $M

    echo "Version con for con tamaño $M:"

    ./SumaVectoresParalelo $M

    echo "Version con sections con tamaño $M:"

    ./SumaVectoresParalelo-sections $M
done
