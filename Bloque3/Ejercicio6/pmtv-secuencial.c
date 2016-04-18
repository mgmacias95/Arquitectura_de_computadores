#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

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
    vector = (int *) malloc(N*sizeof(int));
    sol = (int *) malloc(N*sizeof(int));
    matriz = (int **) malloc(N*sizeof(int*));
    for (i=0; i<N; i++) 
        matriz[i] = (int*) malloc(N*sizeof(int));

    for (i=0; i<N; i++) {
        for (j=i; j<N; j++)
            matriz[i][j] = 3;
        vector[i] = 5;
        sol[i]=0;
    }

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

    // OBTENCION DEL VECTOR SOLUCION
    for (i=0; i<N; i++)
        for (j=i; j<N; j++)
            sol[i] += matriz[i][j] * vector[j];

    // cogemos la ultima componente del vector
    sol[N-1] = matriz[N-1][N-1] * vector[N-1];

    printf("Resultado:\n");
    for (i=0; i<N; i++)
        printf("%d ", sol[i]);
    printf("\n");

    // liberamos memoria
    for (i=0; i<N; i++)
        free(matriz[i]);
    free(matriz);
    free(vector);
    free(sol);

    return 0;
}