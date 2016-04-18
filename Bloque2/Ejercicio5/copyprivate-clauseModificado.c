#include <stdio.h>
#include <omp.h>

main(){
	int n = 9, i, b[n];

	for(i = 0; i < n; i++) 
		b[i] = -1;

	#pragma omp parallel
	{
		int a;
		#pragma omp single /*copyprivate(a)*/
		{
			printf("\nIntroduce valor de inicialización a:");;
			scanf("%d",&a);
			printf("\nSingle ejecutada por el thread %d\n",
				omp_get_thread_num());
		}
		#pragma omp for
		for(i = 0; i < n; i++)
			b[i] = a;
	}

	printf("Después de la región parallel:\n");
	for(i = 0; i < n; i++)
		printf("b[%d] = %d\t",i,b[i]);
	printf("\n");
}