#!/usr/bin/env python2
# -*- coding: utf-8 -*-
""" Este script calcula a quantidade de numeros primos
entre dois numeros : - MINPRIME e MAXPRIME """
from time import time

def isprime(num):
    if (num <= 1):
        return False
    if (num <= 3):
        return True
    if (((num % 2) == 0) or ((num % 3) == 0)):
        return False
    c = 5
    while (c*c <= num):
        if (((num % c) == 0) or ((num % (c+2)) == 0)):
            return False
        c += 6    
    return True

def countprimes(minprime, maxprime):
    count = 0
    for num in range(minprime, maxprime+1):
        if isprime(num):
            count += 1
    return count

minprime = 0
maxprime = 20000000

print("Python")

start_time = time()

count = countprimes(minprime, maxprime)
        
end_time = time()
delta_time = end_time - start_time

print("Number of primes in the interval [%d , %d]: %d" % (minprime, maxprime, count))
print("Time elapsed: %r seconds" % delta_time)
