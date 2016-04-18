/*
	Para compilar usar (-lrt: real time library):
		gcc -fopenmp -O2 sumaVectoresC-Modificado.c -o SumaVectoresParalelo -lrt
	
	Para ejecutar use: SumaVectoresParalelo <longitud>
*/
#include <stdlib.h> // biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> // biblioteca donde se encuentra la función printf()
#ifdef _OPENMP
	#include <omp.h>
#endif
// #define PRINTF_ALL 	// comentar para quitar el printf ...
						// que imprime todos los componentes

//Sólo puede estar definida una de las tres constantes VECTOR_ (sólo uno de los ...
//tres defines siguientes puede estar descomentado):
// #define VECTOR_LOCAL  // descomentar para que los vectores sean variables ...
						// locales (si se supera el tamaño de la pila se ...
						// generará el error "Violación de Segmento")

// #define VECTOR_GLOBAL	// descomentar para que los vectores sean variables ...
						// globales (su longitud no estará limitada por el ...
						// tamaño de la pila del programa)
#define VECTOR_DYNAMIC 	// descomentar para que los vectores sean variables ...
						// dinámicas (memoria reutilizable durante la ejecución)

#ifdef VECTOR_GLOBAL
#define MAX 33554432 //=2^25
double v1[MAX], v2[MAX], v3[MAX];
#endif

int main(int argc, char** argv){
	int i;
	
	//Leer argumento de entrada (no de componentes del vector)
	if (argc<2){
		printf("Faltan no componentes del vector\n");
		exit(-1);
	}

	unsigned int N = atoi(argv[1]); // Máximo N =2^32-1=4294967295 (sizeof(unsigned int) = 4 B)
	
	#ifdef VECTOR_LOCAL
	double v1[N], v2[N], v3[N];  	// Tamaño variable local en tiempo de ejecución ...
									// disponible en C a partir de actualización C99
	#endif

	#ifdef VECTOR_GLOBAL
	if (N>MAX) N=MAX;
	#endif
	
	#ifdef VECTOR_DYNAMIC
	double *v1, *v2, *v3;

	v1 = (double*) malloc(N*sizeof(double));// malloc necesita el tamaño en bytes
	v2 = (double*) malloc(N*sizeof(double)); //si no hay espacio suficiente malloc devuelve NULL
	v3 = (double*) malloc(N*sizeof(double));
	
	if ( (v1==NULL) || (v2==NULL) || (v3==NULL) ){
		printf("Error en la reserva de espacio para los vectores\n");
		exit(-2);
	}
	#endif

	int primer_trozo, segundo_trozo, tercer_trozo, cuarto_trozo;

	//Inicializar vectores
	#pragma omp parallel sections
	{
		#pragma omp section
		{
			for (primer_trozo=0; primer_trozo<(N/4); primer_trozo++) {
				v1[primer_trozo] = N*0.1+primer_trozo*0.1;
				v2[primer_trozo] = N*0.1-primer_trozo*0.1;
			}
		}
		#pragma omp section
		{
			for (segundo_trozo=(N/4); segundo_trozo<(N/2); segundo_trozo++) {
				v1[segundo_trozo] = N*0.1+segundo_trozo*0.1;
				v2[segundo_trozo] = N*0.1-segundo_trozo*0.1;
			}
		}
		#pragma omp section
		{
			for (tercer_trozo=(N/2); tercer_trozo<((3*N)/4); tercer_trozo++) {
				v1[tercer_trozo] = N*0.1+tercer_trozo*0.1;
				v2[tercer_trozo] = N*0.1-tercer_trozo*0.1;
			}
		}
		#pragma omp section
		{
			for (cuarto_trozo=((3*N)/4); cuarto_trozo<N; cuarto_trozo++) {
				v1[cuarto_trozo] = N*0.1+cuarto_trozo*0.1;
				v2[cuarto_trozo] = N*0.1-cuarto_trozo*0.1;
			}
		}
	}

	double start, end, tiempo;
	
	start = omp_get_wtime();

	//Calcular suma de vectores
	#pragma omp parallel sections
	{
		#pragma omp section
		{
			for (primer_trozo=0; primer_trozo<(N/4); primer_trozo++)
				v3[primer_trozo] = v1[primer_trozo] + v2[primer_trozo];
		}
		#pragma omp section
		{
			for (segundo_trozo=(N/4); segundo_trozo<(N/2); segundo_trozo++)
				v3[segundo_trozo] = v1[segundo_trozo] + v2[segundo_trozo];
		}
		#pragma omp section
		{
			for (tercer_trozo=(N/2); tercer_trozo<((3*N)/4); tercer_trozo++)
				v3[tercer_trozo] = v1[tercer_trozo] + v2[tercer_trozo];
		}
		#pragma omp section
		{
			for (cuarto_trozo=((3*N)/4); cuarto_trozo<N; cuarto_trozo++)
				v3[cuarto_trozo] = v1[cuarto_trozo] + v2[cuarto_trozo];
		}
	}

	end = omp_get_wtime();
	tiempo = end - start;
	printf("%11.9f\n", tiempo);
	
	//Imprimir resultado de la suma y el tiempo de ejecución
	#ifdef PRINTF_ALL
	printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:%u\n",tiempo,N);
	for(i=0; i<N; i++)
		printf("/ V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n",
		i,i,i,v1[i],v2[i],v3[i]);

	#else
		if (N==8 || N==11) {
			printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:%u\n",tiempo,N);
			for(i=0; i<N; i++)
				printf("/ V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n",
				i,i,i,v1[i],v2[i],v3[i]);
		}
		else {
			printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:%u\n/ V1[0]+V2[0]=V3[0](%8.6f+%8.6f=%8.6f) / / \n V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n\n",
				tiempo,N,v1[0],v2[0],v3[0],N-1,N-1,N-1,v1[N-1],v2[N-1],v3[N-1]);
		}
	#endif
	#ifdef VECTOR_DYNAMIC
	free(v1); // libera el espacio reservado para v1
	free(v2); // libera el espacio reservado para v2
	free(v3); // libera el espacio reservado para v3
	#endif
	return 0;
}
