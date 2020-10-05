let isPrime n =
    if (n <= 1) then false
    elif (n<= 3) then true
    elif (((n % 2) = 0) || ((n % 3) = 0)) then false
    else
        let rec checkPrime i = 
            if i*i > n then true
            else
                if (((n % i) = 0) || ((n % (i+2)) = 0)) then false
                else checkPrime (i + 6)     
        checkPrime 5
        
[<EntryPoint>]
let main argv =
    
    printfn "F#"
    let minprime = 0
    let maxprime = 20000000
    let mutable count = 0

    let watch = System.Diagnostics.Stopwatch.StartNew();
    
    [minprime..maxprime] |> List.iter (fun num -> if isPrime num then count <- count + 1)

    watch.Stop();
    printfn "Number of primes in the interval [%d,%d]: %d" minprime maxprime count
    let elapsed = (float watch.ElapsedMilliseconds) / 1000.0
    printfn "Time elapsed: %f seconds" elapsed

    System.Console.ReadKey() |> ignore
    0
