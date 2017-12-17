isPrime <- function(n) {
  if (n <= 1) return(FALSE)
  if (n <= 3) return(TRUE)
  if ( ( n %% 2 == 0 ) || ( n %% 3 == 0 ) ) return(FALSE)
  c <- 5
  while ( c*c <= n ) {
    if ( ( n %% c == 0 ) || ( n %% (c+2) == 0 ) ) return(FALSE)
    c <- c + 6
  }
  TRUE
}

print('R')

getprimecount <- function(min, max) {
    cont <- 0
    for (i in seq(min,max,by=1) ) {
        if (isPrime(i)) cont <- cont + 1
    }
    mean(cont)
}

startt <-as.POSIXlt(Sys.time(), "GMT") 

cont <- getprimecount(0, 20000000)

endt <-as.POSIXlt(Sys.time(), "GMT") 

print(endt-startt)
print(cont)
