fn is_prime(n: u64) -> bool {
    if n <= 1 { return false; }
    if n <= 3 { return true;  }
    if (n % 2 == 0) || (n % 3 == 0) { return false; }
    let mut m = 5;
    while m <= (n as f64).sqrt() as u64 {
        if (n % m == 0) || (n % (m + 2) == 0) { return false; }
        m += 6;
    }
    true
}

fn main() {
    use std::time::Instant;

    println!("Rust");

	let mut count = 0;
    let limitmin = 0;
    let limitmax = 20000000;
    let now = Instant::now();
    for n in limitmin..limitmax + 1 {
        if is_prime(n) {
			count+=1;
        }
    }
    let elapsed = now.elapsed();
    let sec = (elapsed.as_secs() as f64) + (elapsed.subsec_nanos() as f64 / 1000_000_000.0);
    println!("Number of primes in the interval [{0},{1}]: {2}", limitmin, limitmax, count);
    println!("Time elapsed: {} seconds", sec);
}
