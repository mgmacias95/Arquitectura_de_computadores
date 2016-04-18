#include <stdio.h>
#include <time.h>

struct {
    int a;
    int b;
}   s[5000];

void Funcion (int *R) {
    int ii, i, X1, X2;

    for(ii = 1; ii <= 40000; ii++){
        X1 = 0; X2 = 0;

        // for (i = 0; i < 5000; i++) {
        //      X1 += 2*s[i].a+ii;
        //      X2 += 2*s[i].b-ii;
        // }

        for (i = 0; i < 5000; i+=4) {
            X1 += 2*s[i].a+ii;
            X2 += 3*s[i].b-ii;
            X1 += 2*s[i+1].a+ii;
            X2 += 3*s[i+1].b-ii;
            X1 += 2*s[i+2].a+ii;
            X2 += 3*s[i+2].b-ii;
            X1 += 2*s[i+3].a+ii;
            X2 += 3*s[i+3].b-ii;
        }

        // if (X1<X2) R[ii] = X1;
        // else R[ii] = X2;
        R[ii] = (X1 < X2) ? X1 : X2;
    }
}

int main()
{
    int R[40000];

    struct timespec cgt1,cgt2; double ncgt;

    clock_gettime(CLOCK_REALTIME,&cgt1);

    Funcion(R);

    clock_gettime(CLOCK_REALTIME,&cgt2);
    ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec)+( double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

    printf("R[0] = %i, R[39999] = %i\n", R[0], R[39999]);
    printf("\nTiempo (seg.) = %11.9f\n", ncgt);

    return 0;
}