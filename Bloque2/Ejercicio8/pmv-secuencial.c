#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void ImprimeMatriz(int filas, int cols, int matriz[filas][cols]) {
    int i, j;
    printf("Matriz:\n");
    for (i=0; i<filas; i++) {
        for (j=0; j<cols; j++)
            printf("%d ", matriz[i][j]);
        printf("\n");
    }
}

void ImprimeVector (int elems, int vector[elems]) {
    int i;
    printf("Vector:\n");
    for (i = 0; i<elems; i++)
        printf("%d ", vector[i]);

    printf("\n");
}

main(int argc, char const *argv[])
{
    // comprobamos que los argumentos son correctos
    if (argc < 2) {
        fprintf(stderr, "Falta el tamanio de la matriz\n");
        exit(-1);
    }

    int N = atoi(argv[1]);

    int matriz[N][N], vector[N];
    int i, j;

    // inicializamos la matriz y el vector
    for (i = 0; i<N; i++) {
        for (j = 0; j<N; j++)
            matriz[i][j] = 3;

        vector[i] = 2;
    }

    // ImprimeMatriz(N,N,matriz);
    // ImprimeVector(N,vector);

    struct timespec cgt1,cgt2; double ncgt; //para tiempo de ejecución
    int vector_resultado[N], k = 0, suma=0;

    clock_gettime(CLOCK_REALTIME, &cgt1);

    // Calculamos el producto
    for (i=0; i<N;i++) {
        // calculamos la suma de la columna de la matriz:
        for (k=0; k<N; k++)
            suma+=matriz[k][i];

        // y ahora multiplicamos la suma por el vector:
        vector_resultado[i] = suma * vector[i];
        suma = 0;
    }

    clock_gettime(CLOCK_REALTIME, &cgt2);

    ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec)+( double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

    if (N < 11) {
        printf("Tiempo: %11.9f\n", ncgt);
        for (i=0; i<N; i++)
            printf("v[%d] = %d\n", i, vector_resultado[i]);
    }

    else
        // printf("Tiempo: %11.9f \t v[0] = %d \t v[%d] = %d \n", ncgt, vector_resultado[0],
        //     N-1, vector_resultado[N-1]);
        printf("%d \t %11.9f\n", N, ncgt);

    return 0;
}