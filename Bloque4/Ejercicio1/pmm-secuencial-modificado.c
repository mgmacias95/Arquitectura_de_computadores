#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void printMatriz (int n, int /***/*m) {
    int i, j;
    for (i=0; i<n; i++) {
        for (j=0; j<n; j++)
            printf("%d ", m[i+j]);
        printf("\n");
    }
}

void pmm (int /***/*a, int /***/*b, int /***/*c, unsigned n, struct timespec *cgt1, struct timespec *cgt2) {
    unsigned i, j, k;

    clock_gettime(CLOCK_REALTIME,cgt1);
    // Multiplicacion
    // for (i=0; i<n; i++)
    //     for (k=0; k<n; k++) 
    //         for (j=0; j<n; j++) 
    //             a[i][j] += b[i][k] * c[k][j];

    for (i=0; i<n; i++)
        for (k=0; k<n; k++)
            for (j=0; j<n; j++)
                a[(i*n)+j] += b[(i*n)+k] * c[(k*n)+j];

    clock_gettime(CLOCK_REALTIME,cgt2);
}

int main(int argc, char const *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "ERROR: falta numero de filas y columnas\n");
        exit(1);
    }

    unsigned n = strtol(argv[1], NULL, 10);
    unsigned i, j;

    // int **a, **b, **c;
    // a = (int **) malloc(n*sizeof(int*));
    // b = (int **) malloc(n*sizeof(int*));
    // c = (int **) malloc(n*sizeof(int*));
    // for (i=0; i<n; i++) {
    //     a[i] = (int *) malloc(n*sizeof(int));
    //     b[i] = (int *) malloc(n*sizeof(int));
    //     c[i] = (int *) malloc(n*sizeof(int));
    // }
    int *a, *b, *c, *new_a, *new_b, *new_c;
    unsigned n_cuadrado = n*n;
    a = (int *) malloc(sizeof(int)*n_cuadrado + 63);
    new_a = (int *) (((long int)a+63) & ~(63));
    b = (int *) malloc(sizeof(int)*n_cuadrado + 63);
    new_b = (int *) (((long int)b+63) & ~(63));
    c = (int *) malloc(sizeof(int)*n_cuadrado + 63);
    new_c = (int *) (((long int)c+63) & ~(63));


    // Inicializcion
    // for (i=0; i<n; i++) {
    //     for (j=0; j<n; j++) {
    //         a[i][j] = 0;
    //         b[i][j] = /*i+1*/2;
    //         c[i][j] = /*j+1*/1;
    //     }
    // }

    for (i=0; i<n; i++) {
       for (j=0; j<n; j++) {
           new_a[(i*n)+j] = 0;
           new_b[(i*n)+j] = 2;
           new_c[(i*n)+j] = 1;
       }
    }

    struct timespec cgt1,cgt2; double ncgt;

    pmm(new_a,new_b,new_c,n,&cgt1,&cgt2);
    
    ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec)+( double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

    if (n < 15) {
        printf("M1:\n");
        printMatriz(n, new_b);
        printf("M2:\n");
        printMatriz(n, new_c);
        printf("Sol:\n");
        printMatriz(n, new_a);
    }
    else
        printf("Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n",ncgt,new_a[0],new_a[(n-1)+(n-1)]);

    // for (i=0; i<n; i++) {
    //     free(a[i]);
    //     free(b[i]);
    //     free(c[i]);
    // }

    free(a);
    free(b);
    free(c);

    return 0;
}