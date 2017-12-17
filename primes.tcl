#!/usr/bin/tclsh

proc is_prime {n} {
    if {$n <= 1} {return false}
    if {$n <= 3} {return true}
    if {$n % 2 == 0 || $n % 3 == 0} {return false}
    set c 5
    while {$c*$c <= $n} {
        if {$n % $c == 0 || $n%($c+2) == 0 } {return false}
        incr c 6
    }
    return true
}

set starttime [clock clicks -milliseconds]
puts "TCL";

set count 0
set limit 20000000

for {set i 0} {$i <= $limit} {incr i}  {
	set isPrime [is_prime $i]
	if {$isPrime} {
		incr count
	}
}
puts "[expr int([expr [clock clicks -milliseconds] - $starttime] / 1000)]sec\t\t"
puts "$count"

exit




