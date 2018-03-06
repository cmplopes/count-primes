using System;
using System.Collections;
using System.Collections.Generic;
 
namespace SieveOfEratosthenes
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine ("C# - Sieve");
            int minprime = 0, maxprime = 20000000;
            var watch = System.Diagnostics.Stopwatch.StartNew();
            var primelist = GetAllPrimesLessThan(maxprime);
            //foreach (int prime in primelist)
            //{
            //    Console.WriteLine(prime);
            //}
            watch.Stop();
            Console.WriteLine ("Number of primes in the interval [{0},{1}]: {2}",minprime,maxprime,primelist.Count);
            Console.WriteLine ("Time elapsed: {0} seconds",watch.ElapsedMilliseconds/1000.0);
        }
 
        private static List<int> GetAllPrimesLessThan(int maxPrime)
        {
            var primes = new List<int>();
            var maxSquareRoot = (int)Math.Sqrt(maxPrime);
            var eliminated = new BitArray(maxPrime + 1);
 
            for (int i = 2; i <= maxPrime; ++i)
                if (!eliminated[i])
                {
                    primes.Add(i);
                    if (i <= maxSquareRoot)
                        for (int j = i * i; j <= maxPrime; j += i)
                            eliminated[j] = true;
                }
            return primes;
        }
    }
}
