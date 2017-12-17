//============================================================================
// Name        : Primes.cpp
// Author      : Carlos Lopes
// Version     :
// Copyright   : Your copyright notice
// Description : isPrime
//============================================================================

#include <iostream>
#include <time.h>

using namespace std;

long diff_nano(struct timespec *start, struct timespec *end)
{
    /* ns */
    return ( (end->tv_sec * 1000000000 ) + (end->tv_nsec) -
             (start->tv_sec * 1000000000) - (start->tv_nsec) );
}

bool isPrime(int num)
{
    if (num <= 1) return false;
    if (num <= 3) return true;
    if (((num % 2) == 0) || ((num % 3) == 0)) return false;
    for (int c = 5; c*c <= num; c += 6)
        if (((num % c) == 0) || ((num % (c+2)) == 0)) return false;
    return true;
}

int main(int argc, char* argv[])
{
    struct timespec tstart, tend;

    int minprime = 0, maxprime = 20000000, num, count = 0;

    std::cout << "C++\n";

    clock_gettime(CLOCK_MONOTONIC, &tstart);
    for (num = minprime; num <= maxprime; num++)
        if (isPrime(num)) count++;
    clock_gettime(CLOCK_MONOTONIC, &tend);
    double time_spent = diff_nano(&tstart, &tend) / 1000000000.;

    std::cout << "Number of primes in the interval ["
              << minprime << "," << maxprime << "]: " << count
              << "\nTime elapsed: " << time_spent << " seconds.\n";

    return 0;
}
