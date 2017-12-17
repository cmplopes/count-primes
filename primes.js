'use strict';

// Sieve of Eratosthenes
function eratosthenes(limit) {
    let prms = [];
    if (limit >= 2) prms = [2];
    if (limit >= 3) {
        let sqrtlmt = (Math.sqrt(limit) - 3) >> 1;
        let lmt = (limit - 3) >> 1;
        let bfsz = (lmt >> 5) + 1;
        let buf = [];
        for (let i = 0; i < bfsz; i++)
            buf.push(0);
        for (let i = 0; i <= sqrtlmt; i++)
            if ((buf[i >> 5] & (1 << (i & 31))) == 0) {
                let p = i + i + 3;
                for (let j = (p * p - 3) >> 1; j <= lmt; j += p)
                    buf[j >> 5] |= 1 << (j & 31);
            }
        for (let i = 0; i <= lmt; i++)
            if ((buf[i >> 5] & (1 << (i & 31))) == 0)
                prms.push(i + i + 3);
    }
    return prms;
}

function isPrime(num) {
    if (num <= 1) return false;
    if (num <= 3) return true;
    if (((num % 2) == 0) || ((num % 3) == 0)) return false;
    for (let c = 5; c*c <= num; c += 6) 
        if (((num % c) == 0) || ((num % (c+2)) == 0)) return false;
    return true;
}

// Primos
let noPrimes = 0;
const min = 0, limit = 20000000;

console.log('JavaScript');
let time_start = new Date().getTime();
for (var num = 0; num <= limit; num++) 
    if (isPrime(num)) noPrimes++;
let time_end = new Date().getTime();
let delta_time = (time_end - time_start) / 1000;
console.log("Number of primes in the interval [" + min + "," + limit + "]: " + noPrimes);
console.log('Execution time: ' + delta_time + ' seconds');

console.log('Sieve of Eratosthenes');
time_start = new Date().getTime();
const primes = eratosthenes(limit);
time_end = new Date().getTime();
delta_time = (time_end - time_start) / 1000;
console.log("Number of primes in the interval [" + min + "," + limit + "]: " + primes.length);
console.log('Execution time: ' + delta_time + ' seconds');
//console.log(primes);
