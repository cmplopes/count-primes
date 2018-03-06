#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <omp.h>

int runEratosthenesSieve(int upperBound) 
{
    int count = 0;
    int m, k;
    int upperBoundSquareRoot = (int)sqrt((double)upperBound);

    char *isPrime = malloc( sizeof(char) * (upperBound + 1) );
    memset(isPrime, 1, sizeof(char) * (upperBound + 1));

    int iCPU = omp_get_num_procs();
    omp_set_num_threads(iCPU);

    for (m = 2; m <= upperBoundSquareRoot; m++) 
        if (isPrime[m]==1) 
            #pragma omp parallel for private(k) shared(isPrime) num_threads(4) 
            for (k = m * m; k <= upperBound; k += m) 
                isPrime[k] = 0;
                
    #pragma omp parallel for private(k) shared(isPrime) num_threads(4) reduction(+:count)  
    for (m = 2; m <= upperBound; m++)
        if (isPrime[m]==1)
        {
            count++;
            //printf ("%d ", m);
        }
    //printf ("\n");
    free(isPrime);
    return count;
}

long diff_nano(struct timespec *start, struct timespec *end)
{
    /* ns */
    return ( (end->tv_sec * 1000000000 ) + (end->tv_nsec) -
             (start->tv_sec * 1000000000) - (start->tv_nsec) );
}


int main()
{
    struct timespec tstart, tend;
    int minprime = 2, maxprime = 20000000;

    printf("C - Sieve of Eratosthenes\n");

    clock_gettime(CLOCK_MONOTONIC, &tstart);

    int count = runEratosthenesSieve(maxprime);

    clock_gettime(CLOCK_MONOTONIC, &tend);
    double time_spent = diff_nano(&tstart, &tend) / 1000000.;

    printf("Number of primes in the interval [%d,%d]: %d\n",minprime, maxprime, count);
    printf("Time elapsed: %f ms\n",time_spent);

    return 0;
}




