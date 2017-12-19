program pimes;

{$AppType CONSOLE}

uses SysUtils, DateUtils;

function isPrime(num: Longint): boolean;
var c: Longint;
begin
    if (num <= 1) then exit(False);
    if (num <= 3) then exit(True);
    if ( ((num mod 2) = 0) or ((num mod 3) = 0) ) then exit(False);
    c := 5;
    while c*c <= num do begin
        if (((num mod c) = 0) or ((num mod (c+2)) = 0)) then exit(False);
        Inc(c, 6);
    end;
    exit(True);
end;

var i, Count, minprime, maxprime: Longint;
    start_time, end_time, delta_time: tdatetime;
begin
    minprime := 0;
    maxprime := 20000000;
    Count    := 0;
  
    writeln('Pascal');

    start_time := now;
    for i := minprime to maxprime do
        if isPrime(i) then Inc(Count);
    end_time := now;
    delta_time := MilliSecondsBetween(start_time, end_time) / 1000;
  
    writeln('Number of primes in the interval [', minprime, ',', maxprime,']: ',count);
    writeln('Time elapsed: ', delta_time, ' seconds');
end.
