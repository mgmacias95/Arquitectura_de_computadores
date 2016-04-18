#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef _OPENMP
    #include <omp.h>
#else
    #define omp_get_thread_num() 0
#endif

int main(int argc, char const *argv[])
{
    int i, n = 200, chunk, a[n], suma=0;

    if (argc < 2) {
        fprintf(stderr, "\nFalta iteraciones o chunk\n");
        exit(-1);
    }

    n = atoi(argv[1]);
    if (n>200)
        n = 200;
    chunk = atoi(argv[2]);

    for (i = 0; i < n; i++)
        a[i] = i;

    printf("dyn-var: %d\n",omp_get_dynamic());
    printf("nthreads-var: %d\n", omp_get_max_threads());
    omp_sched_t schedule_type;
    int chunk_size;
    omp_get_schedule(&schedule_type, &chunk_size);
    printf("run-sched-var:\n"); 
    if (schedule_type == omp_sched_static) printf("\tomp_sched_static\n");
    else if (schedule_type == omp_sched_dynamic) printf("\tomp_sched_dynamic\n");
    else if (schedule_type == omp_sched_guided) printf("\tomp_sched_guided\n");
    else /*if (schedule_type == omp_sched_auto)*/ printf("\tomp_sched_auto\n");
    printf("\tchunk: %d\n", chunk_size);

    int set_dyn;
    do {
        printf("Introduce dyn-var: ");
        scanf("%i",&set_dyn);
        omp_set_dynamic(set_dyn);
    } while(set_dyn > 1);

    int n_threads;
    printf("Introduce nthreads-var: ");
    scanf("%i",&n_threads);
    omp_set_num_threads(n_threads);

    char sched_t[20];
    printf("Introduce schedule_type: ");
    scanf("%s",sched_t);
    printf("Introduce chunk_size: ");
    scanf("%i",&chunk_size);
    if (strcmp(sched_t, "omp_sched_static") == 0) schedule_type = omp_sched_static;
    else if (strcmp(sched_t, "omp_sched_dynamic") == 0) schedule_type = omp_sched_dynamic;
    else if (strcmp(sched_t, "omp_sched_guided") == 0) schedule_type = omp_sched_guided;
    else if (sched_t == "omp_sched_auto") schedule_type = omp_sched_auto;
    omp_set_schedule(schedule_type, chunk_size);

    #pragma omp parallel for firstprivate(suma)\
            lastprivate(suma) schedule(dynamic, chunk)
    for (i=0; i<n; i++) {
        suma = suma+a[i];
        printf("thread %d suma a[%d] suma=%d\n", 
            omp_get_thread_num(), i, a[i], suma);
    }

    printf("Fuera de 'parallel for' suma = %d\n", suma);

    printf("dyn-var: %d\n",omp_get_dynamic());
    printf("nthreads-var: %d\n", omp_get_max_threads());
    omp_get_schedule(&schedule_type, &chunk_size);
    printf("run-sched-var:\n"); 
    if (schedule_type == omp_sched_static) printf("\tomp_sched_static\n");
    else if (schedule_type == omp_sched_dynamic) printf("\tomp_sched_dynamic\n");
    else if (schedule_type == omp_sched_guided) printf("\tomp_sched_guided\n");
    else /*if (schedule_type == omp_sched_auto)*/ printf("\tomp_sched_auto\n");
    printf("\tchunk: %d\n", chunk_size); 

    return 0;
}