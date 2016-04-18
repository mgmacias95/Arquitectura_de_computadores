#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

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
    #pragma omp parallel for private(i,j)
    for (i = 0; i<N; i++) {
        for (j = 0; j<N; j++)
            matriz[i][j] = 3;

        vector[i] = 2;
    }

    // ImprimeMatriz(N,N,matriz);
    // ImprimeVector(N,vector);

    int vector_resultado[N], k = 0, suma=0, suma_pri=0;

    double start, end, tiempo;
    start = omp_get_wtime();

    // Calculamos el producto: version 1, bucle que recorre las filas de la matriz
    for (i=0; i<N; i++) {
        suma = 0;
        // calculamos la suma de la columna de la matriz:
        #pragma omp parallel firstprivate(suma_pri)
        {
            #pragma omp for private(k)
                for (k=0; k<N; k++)
                    suma_pri+=matriz[k][i];

            #pragma omp atomic
                suma+=suma_pri;
        }

        vector_resultado[i] = suma * vector[i];
    }

    end = omp_get_wtime();
    tiempo = end - start;

    if (N < 11) {
        printf("Tiempo: %11.9f\n", tiempo);
        for (i=0; i<N; i++)
            printf("v[%d] = %d\n", i, vector_resultado[i]);
    }

    else
        // printf("Tiempo: %11.9f \t v[0] = %d \t v[%d] = %d \n", tiempo, vector_resultado[0],
        //     N-1, vector_resultado[N-1]);
        printf("%d \t %11.9f\n", N, tiempo);

    return 0;
}