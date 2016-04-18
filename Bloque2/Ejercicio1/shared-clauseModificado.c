#include <stdio.h>
#ifndef _OPENMP
    #include <omp.h>
#endif

int main(int argc, char const *argv[])
{
    int i, n=7;
    int a[n];

    for (i=0;i<n;i++)
        a[i]=i+1;

    #pragma omp parallel for default(none) shared(a, n)
    for (i=0;i<n;i++)   a[i]+=i;

    printf("Despues de parallel for:\n");

    for (i = 0; i < n; ++i)
        printf("a[%d]=%d\n", i,a[i]);

    return 0;
}