import Foundation

func is_prime(n: Int) -> Bool {
    if n <= 1 { return false }
    if n <= 3 { return true  }
	if (((n % 2) == 0) || ((n % 3) == 0)) { return false }
    var c = 5
    while c*c <= n {
        if (((n % c) == 0) || ((n % (c + 2)) == 0)) { return false }
        c = c + 6
    }
    return true
}

let numbers = 1...20000000
var count = 0
let start = Date()

print("Swift")
for i in numbers {
    if(is_prime(n:i)) { count = count + 1 }
}
let end = Date()

print("\(count) primes.")

print("Time to do something: \(end.timeIntervalSince(start)) seconds");
