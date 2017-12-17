package main
 
import (
    "fmt"
    "time"
)

func IsPrime(num int) bool {
    if (num <= 1) {return false}
    if (num <= 3) {return true}
    if (((num % 2) == 0) || ((num % 3) == 0)) {return false}
    for c := 5; c*c <= num; c += 6 {
        if (((num % c) == 0) || ((num % (c+2)) == 0)) {return false}
    }
    return true
}
 
func main() {
    count := 0
    start := time.Now()
    for i := 0; i <= 20000000; i++ {
        if IsPrime(i) {
            count++
        }
    }
    elapsed := time.Since(start)
    fmt.Println("GO")
    fmt.Println("Prime count = ", count)
    fmt.Println("Took ", elapsed)
    fmt.Println()
}
