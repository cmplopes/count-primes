#!/usr/bin/env ruby

def isPrime num
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

min = 0
max = 20000000
no_primes = 0

puts "Ruby"

beginning_time = Time.now

num = min
while num <= max
  no_primes += 1 if isPrime num
  num+=1
end

end_time = Time.now
delta_time = end_time - beginning_time

puts "Number of primes in the interval [#{min},#{max}]: #{no_primes}"
puts "Time elapsed: #{delta_time} seconds"
