#include <stdio.h>
#include <pthread.h>
#include <time.h>

void * thread_sum(void *);
int isPrime(int num);
long diff_nano(struct timespec *start, struct timespec *end);

const int nThreads = 4;
pthread_mutex_t mVar = PTHREAD_MUTEX_INITIALIZER;
int TotalCount = 0;
int minprime = 0, maxprime = 20000000;

void *thread_sum(void *no)
{
    int *ifrom, iCount;
    ifrom = (int*) no;
    for (iCount = *ifrom; iCount <= maxprime; iCount+=(nThreads))
    {
        if ( isPrime(iCount) == 1)
        {
            pthread_mutex_lock(&mVar);
            TotalCount++;
            pthread_mutex_unlock(&mVar);
        }
    }
    pthread_exit(NULL);
}

int isPrime(int num)
{
    if (num <= 1) return 0;
    if (num <= 3) return 1;
    if (((num % 2) == 0) || ((num % 3) == 0)) return 0;
    int c;
    for (c = 5; c * c <= num; c += 6)
        if (((num % c) == 0) || ((num % (c + 2)) == 0)) return 0;
    return 1;
}

long diff_nano(struct timespec *start, struct timespec *end)
{
    /* ns */
    return ( (end->tv_sec * 1000000000 ) + (end->tv_nsec) -
             (start->tv_sec * 1000000000) - (start->tv_nsec) );
}

int main()
{
    int iCount;
    int threadPara[nThreads];
    
    struct timespec tstart, tend;
    pthread_t tid[nThreads];
		
    printf("C with %d Threads\n",nThreads);

    clock_gettime(CLOCK_MONOTONIC, &tstart);

    for (iCount = 0; iCount < nThreads; iCount++)
    {
        threadPara[iCount] = iCount;
        pthread_create(&tid[iCount], NULL, &thread_sum, (void *) &threadPara[iCount]);
    }

    for (iCount = 0; iCount < nThreads; iCount++)
    {
        pthread_join(tid[iCount], NULL);
    }

    clock_gettime(CLOCK_MONOTONIC, &tend);
    double time_spent = diff_nano(&tstart, &tend) / 1000000000.;

    printf("Number of primes in the interval [%d,%d]: %d\n",
           minprime, maxprime, TotalCount);
    printf("Time elapsed: %f seconds\n",time_spent);
         
    return 0;
}
