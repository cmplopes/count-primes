<?php
    function isPrime($num) {
        if ($num <= 1) return false;
        if ($num <= 3) return true;
        if ((($num % 2) == 0) || (($num % 3) == 0)) return false;
        for ($c = 5; $c*$c <= $num; $c += 6)
            if ((($num % $c) == 0) || (($num % ($c+2)) == 0)) 
                return false;
        return true;
    }
 
    $min = 0; $max = 20000000; $cont= 0;
    
    echo "PHP\n";

    $time_start = microtime(true);
    for ($num = $min; $num <= $max; $num++) {
        if (isPrime($num)) $cont++;
    }
    $time_end = microtime(true);
    $delta_time = ($time_end - $time_start);
    
    echo "Number of primes in the interval [".$min.",".$max."]: ".$cont."\n";
    echo "Time elapsed: ".$delta_time." seconds\n";
?>
