#include <iostream>
#include <cstring>
#include <math.h>
#include <time.h>
#include <omp.h>

using namespace std;

long diff_nano(struct timespec *start, struct timespec *end)
{
    return ( (end->tv_sec * 1000000000 ) + (end->tv_nsec) -
             (start->tv_sec * 1000000000) - (start->tv_nsec) );
}

int runEratosthenesSieve(int upperBound) 
{
    int m, k;
    int upperBoundSquareRoot = (int)sqrt((double)upperBound);
    bool *isPrime = new bool[upperBound + 1];
    memset(isPrime, 1, sizeof(bool) * (upperBound + 1));
    int count = 0 ;

    int iCPU = omp_get_num_procs();
    omp_set_num_threads(iCPU);

    for (m = 2; m <= upperBoundSquareRoot; m++) 
        if (isPrime[m])
            #pragma omp parallel for private(k) shared(isPrime)
            for (k = m * m; k <= upperBound; k += m) 
                isPrime[k] = false;
                
 
    #pragma omp parallel for private(k) shared(isPrime) reduction(+:count) 
    for (m = 2; m <= upperBound; m++)
        if (isPrime[m])
            count++;
    
    delete [] isPrime;
    return count;
}

int main(int argc, char* argv[])
{
    struct timespec tstart, tend;

    int minprime = 2, maxprime = 20000000;

    std::cout << "C++ Sieve of Eratosthenes\n";

    clock_gettime(CLOCK_MONOTONIC, &tstart);
    int count = runEratosthenesSieve(maxprime);
    clock_gettime(CLOCK_MONOTONIC, &tend);

    double time_spent = diff_nano(&tstart, &tend) / 1000000.;

    std::cout << "Number of primes in the interval ["
              << minprime << "," << maxprime << "]: " << count
              << "\nTime elapsed: " << time_spent << " ms.\n";

    return 0;
}


