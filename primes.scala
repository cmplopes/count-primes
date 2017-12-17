import scala.util.control.Breaks._

object FindPrimes {

	def main(args : Array[String]) {

		var vmin = 0
		var vmax = 20000000
		var counter = 0
		println("Scala")
		time {
			for (n <- vmin to vmax) {
				if (isPrime(n))	counter += 1 
			}
		}
		println("There are "+ counter + " primes between ["+vmin+","+vmax+"]")
	}

	def time[R](block: => R): R = {  
	    val t0 = System.nanoTime()
	    val result = block    // call-by-name
	    val t1 = System.nanoTime()
	    println("Elapsed time: " + (t1 - t0)/1000000000.0 + " s")
	    result
	}

	def isPrime(num : Int) : Boolean = {
        if (num <= 1) return false
        if (num <= 3) return true
        if (((num % 2) == 0) || ((num % 3) == 0)) return false
        breakable {
			for (c <- 5 until num by 6) {
				if (((num % c) == 0) || ((num % (c + 2)) == 0)) {
					return false;
				}
				if (c*c>num) break
			}
		}
        return true;  
	}

}
