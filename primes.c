#include <stdio.h>
#include <time.h>

long diff_nano(struct timespec *start, struct timespec *end)
{
    /* ns */
    return ( (end->tv_sec * 1000000000 ) + (end->tv_nsec) -
             (start->tv_sec * 1000000000) - (start->tv_nsec) );
}

int isPrime(int num)
{
    if (num <= 1) return 0;
    if (num <= 3) return 1;
    if (((num % 2) == 0) || ((num % 3) == 0)) return 0;
    int c;
    for (c = 5; c*c <= num; c += 6)
        if (((num % c) == 0) || ((num % (c+2)) == 0)) return 0;
    return 1;
}

int main()
{
    struct timespec tstart, tend;
    int minprime = 0, maxprime = 20000000, num, count = 0;

    printf("C\n");

    clock_gettime(CLOCK_MONOTONIC, &tstart);
    for (num = minprime; num <= maxprime; num++)
        if (isPrime(num)) count++;
    clock_gettime(CLOCK_MONOTONIC, &tend);
    double time_spent = diff_nano(&tstart, &tend) / 1000000000.;

    printf("Number of primes in the interval [%d,%d]: %d\n",minprime, maxprime, count);
    printf("Time elapsed: %f seconds\n",time_spent);

    return 0;
}
