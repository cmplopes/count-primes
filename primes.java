public class Primes {

    public static void main (String[] args) {        
        int counter=0;
        int min = 0;
        int max = 20000000;
       
        System.out.println("Java " + java.lang.Runtime.version());

        double startTime = System.nanoTime();
        for (int num = min; num <= max; num++) {             
            if(IsPrime(num)) { counter = counter + 1; }
        }
        double endTime = System.nanoTime();
     
        System.out.println("Number of primes in the interval [" + min + "," + max + "]: " + counter);
        System.out.println("Execution time: " + (endTime - startTime) / 1000000000 + " seconds");

    }
    
    private static boolean IsPrime(int num) {
        if (num <= 1) {
            return false;
        }
        if (num <= 3) {
            return true;
        }
        if (((num % 2) == 0) || ((num % 3) == 0)) {
            return false;
        }
        for (int c = 5; c * c <= num; c += 6) {
            if (((num % c) == 0) || ((num % (c + 2)) == 0)) {
                return false;
            }
        }
        return true;
    }
}
