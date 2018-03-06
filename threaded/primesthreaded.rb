#!/usr/bin/env ruby

require 'thread'
@mutex = Mutex.new
@no_primes = 0

def isPrime(num)
    return false if (num <= 1)
    return true if (num <= 3)
    return false if (((num % 2) == 0) or ((num % 3) == 0))
    c = 5
    while c*c <= num
        return false if (((num % c) == 0) or ((num % (c+2)) == 0))
        c+=6
    end
    return true      
end

def countPrimes(min, max, step)
    num = min
    while num <= max
        if isPrime(num)
            @mutex.synchronize {
                @no_primes += 1
            }
        end
        num = num + step
    end
end    


min = 0
max = 20000000

puts "Ruby 4 threads"

beginning_time = Time.now

threads = []
4.times do |i|
   threads[i] = Thread.new { countPrimes(min+i, max, 4) }
end

threads.map(&:join)

@mutex.lock

end_time = Time.now
delta_time = end_time - beginning_time

puts "Number of primes in the interval [#{min},#{max}]: #{@no_primes}"
puts "Time elapsed: #{delta_time} seconds"
