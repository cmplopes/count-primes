#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from time import time

def eratosthenes2(n):
    multiples = set()
    for i in range(2, n+1):
        if i not in multiples:
            yield i
            multiples.update(range(i*i, n+1, i))
 
minprime = 0
maxprime = 20000000
start_time = time() 
primes = list(eratosthenes2(maxprime))
end_time = time()
delta_time = end_time - start_time
print("Number of primes in the interval [%d , %d]: %d" % (minprime, maxprime, len(primes)))
print("Time elapsed: %r seconds" % delta_time)
