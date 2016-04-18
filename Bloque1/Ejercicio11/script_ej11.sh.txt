#!/bin/bash
for((N=16;N<27;N=N+1))
do
    let M=2**$N

    echo "Version secuencial con tamaño $M:"
    time ./SumaVectoresSecuencial $M

    echo "Version con for de tamaño $M:"
    time ./SumaVectoresParalelo $M
done
