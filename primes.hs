import Control.Exception
import Data.Time

isPrime :: Int -> Bool
isPrime n 
    | n <= 1 = False
    | n <= 3 = True
    | (mod n 2) == 0 || (mod n 3) == 0 = False
    | otherwise = go 5
    where
        go c
            | c * c > n = True
            | (mod n c) == 0 || (mod n (c+2)) == 0 = False 
            | otherwise = go (c+6)

-- pi(n) - the prime counting function, the number of prime numbers <= n
primesNo :: Int -> Int
primesNo 0 = 0
primesNo n
    | isPrime n = 1 + primesNo (n-1)
    | otherwise = 0 + primesNo (n-1)

main = do
    start <- getCurrentTime
    print $ primesNo (20000000)
    end <- getCurrentTime
    print (diffUTCTime end start)
