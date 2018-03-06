#include <iostream>
#include <thread>
#include <mutex>

using namespace std;

std::mutex mtx;
int TotalCount = 0;

bool isPrime(int num);
void sum_primes(int minp, int maxp, int step);
long diff_nano(struct timespec *start, struct timespec *end);

int main(int argc, char* argv[])
{
    struct timespec tstart, tend;

    const int nThreads = 4;

    std::thread tid[nThreads];

    int minprime = 0, maxprime = 20000000;

    std::cout << "C++ with " << nThreads <<" threads\n";

    clock_gettime(CLOCK_MONOTONIC, &tstart);
    
    for (int i=0; i<nThreads; i++)
        tid[i] = std::thread(sum_primes, minprime + i, maxprime, nThreads);

    for (int i=0; i<nThreads; i++)
        tid[i].join();

    clock_gettime(CLOCK_MONOTONIC, &tend);
    double time_spent = diff_nano(&tstart, &tend) / 1000000000.;

    std::cout << "Number of primes in the interval ["
              << minprime << "," << maxprime << "]: " << TotalCount
              << "\nTime elapsed: " << time_spent << " seconds.\n";

    return 0;
}

void sum_primes(int minp, int maxp, int step)
{
    for (int i = minp; i <= maxp; i += step)
        if (isPrime(i))
        {
            mtx.lock();
            TotalCount++;
            mtx.unlock();;
        }
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

long diff_nano(struct timespec *start, struct timespec *end)
{
    /* ns */
    return ( (end->tv_sec * 1000000000 ) + (end->tv_nsec) -
             (start->tv_sec * 1000000000) - (start->tv_nsec) );
}
