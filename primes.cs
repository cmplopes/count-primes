using System;

namespace dockerizecsharp
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Console.WriteLine ("C#");
			int minprime = 0, maxprime = 20000000, num, count = 0;
			var watch = System.Diagnostics.Stopwatch.StartNew();
			for (num = minprime; num <= maxprime; num++)
				if (isPrime(num)) count++;
			watch.Stop();
			Console.WriteLine ("Number of primes in the interval [{0},{1}]: {2}",minprime,maxprime,count);
			Console.WriteLine ("Time elapsed: {0} seconds",watch.ElapsedMilliseconds/1000.0);
		}
		
		static bool isPrime(int n)
		{
			if (n <= 1) return false;
			if (n <= 3) return true;
			if (((n % 2) == 0) || ((n % 3) == 0)) return false;
			for (int i = 5; i*i <= n; i += 6)            
				if (((n % i) == 0) || ((n % (i+2)) == 0)) return false;
			return true;
		}
		
	}
}

