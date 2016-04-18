#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void printMatriz (int n, int **m) {
    int i, j;
    for (i=0; i<n; i++) {
        for (j=0; j<n; j++)
            printf("%d ", m[i][j]);
        printf("\n");
    }
}

int main(int argc, char const *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "ERROR: falta numero de filas y columnas\n");
        exit(1);
    }

    unsigned n, i, j, k;
    n = strtol(argv[1], NULL, 10);

    int **a, **b, **c;
    a = (int **) malloc(n*sizeof(int*));
    b = (int **) malloc(n*sizeof(int*));
    c = (int **) malloc(n*sizeof(int*));
    for (i=0; i<n; i++) {
        a[i] = (int *) malloc(n*sizeof(int));
        b[i] = (int *) malloc(n*sizeof(int));
        c[i] = (int *) malloc(n*sizeof(int));
    }

    // Inicializcion
    for (i=0; i<n; i++) {
        for (j=0; j<n; j++) {
            a[i][j] = 0;
            b[i][j] = /*i+1*/2;
            c[i][j] = /*j+1*/1;
        }
    }

    struct timespec cgt1,cgt2; double ncgt;

    clock_gettime(CLOCK_REALTIME,&cgt1);
    // Multiplicacion
    for (i=0; i<n; i++)
        for (j=0; j<n; j++) 
            for (k=0; k<n; k++) 
                a[i][j] += b[i][k] * c[k][j];
    clock_gettime(CLOCK_REALTIME,&cgt2);
    
    ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec)+( double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

    if (n < 15) {
        printf("M1:\n");
        printMatriz(n, b);
        printf("M2:\n");
        printMatriz(n, c);
        printf("Sol:\n");
        printMatriz(n, a);
    }
    else
        printf("Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n",ncgt,a[0][0],a[n-1][n-1]);

    for (i=0; i<n; i++) {
        free(a[i]);
        free(b[i]);
        free(c[i]);
    }

    free(a);
    free(b);
    free(c);

    return 0;
}