#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
    #include <omp.h>
#endif
#include <string.h>

// #define TESTING
#define FINAL

int main(int argc, char const *argv[])
{
    // COMPROBACION DE ARGUMENTOS
    if (argc < 2) {
        fprintf(stderr, "Falta el tamanio de la matriz\n");
        exit(-1);
    }

    int N = atoi(argv[1]);

    int **matriz; 
    int *vector;
    int *sol;
    int i, j;

    // INICIALIZACION: asumimos que la matriz es triangular superior
    matriz = (int **) malloc(N*sizeof(int*));
    vector = (int *) malloc(N*sizeof(int));
    sol = (int *) malloc(N*sizeof(int));
    for (i=0; i<N; i++) 
        matriz[i] = (int*) malloc(N*sizeof(int));

    #pragma omp parallel for private(j) schedule(runtime)
    for (i=0; i<N; i++) {
        for (j=i; j<N; j++)
            matriz[i][j] = 3;
        vector[i] = 5;
        sol[i] = 0;
    }

    #ifdef TESTING
    printf("Matriz:\n");
    for (i=0; i<N; i++) {
        for (j=0; j<N; j++){
            if (j >= i)
                printf("%d ", matriz[i][j]);
            else
                printf("0 ");
        }
        printf("\n");
    }

    printf("Vector:\n");
    for (i=0; i<N; i++)
        printf("%d ", vector[i]);
    printf("\n");
    #endif

    double start, end, tiempo;
    start = omp_get_wtime();
    // OBTENCION DEL VECTOR SOLUCION
    // con schedule(runtime) el usuario podra escoger la 
    // planificacion que quiera con OMP_SCHEDULE
    #pragma omp parallel for private(j) schedule(runtime)
    for (i=0; i<N; i++)
        for (j=i; j<N; j++) 
            sol[i] += matriz[i][j] * vector[j];

    // cogemos la ultima componente del vector
    sol[N-1] = matriz[N-1][N-1] * vector[N-1];
    end = omp_get_wtime();
    tiempo = end - start;

    #ifdef TESTING
    printf("Resultado:\n");
    for (i=0; i<N; i++)
        printf("%d ", sol[i]);
    printf("\n");
    #endif

    #ifdef FINAL
    printf("Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n",tiempo,sol[0],sol[N-1]);
    #endif

    return 0;
}