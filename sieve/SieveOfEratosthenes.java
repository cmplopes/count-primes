class SieveOfEratosthenes {
    public boolean prime[];

    public static void main(String[] args) {
        int counter = 0;
        int min = 0;
        int max = 20000000;

        System.out.println("Sieve Of Eratosthenes");
        System.out.println("Java " + java.lang.Runtime.version());
        double startTime = System.nanoTime();
        SieveOfEratosthenes g = new SieveOfEratosthenes();
        g.sieveOfEratosthenes(20000000);
        counter = g.Count();
        double endTime = System.nanoTime();
        System.out.println("Number of primes in the interval [" + min + "," + max + "]: " + counter);
        System.out.println("Execution time: " + (endTime - startTime) / 1000000000 + " seconds");
    }

    public int Count() {
        int count = 0;
        for (boolean b : prime)
            if (b)
                count++;
        return count;
    }

    void sieveOfEratosthenes(int n) {
        prime = new boolean[n + 1];
        for (int i = 2; i < n; i++)
            prime[i] = true;
        for (int p = 2; p * p <= n; p++) {
            if (prime[p] == true) {
                for (int i = p * 2; i <= n; i += p)
                    prime[i] = false;
            }
        }
    }
}