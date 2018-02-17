program primes

    use ISO_FORTRAN_ENV

    implicit none
    integer(int32) :: minNumber = 0
    integer(int32) :: maxNumber = 20000000

    call countPrimes(minNumber, maxNumber)

    return

contains

    function isNumberPrime(number) result(isPrime)
       use ISO_FORTRAN_ENV
       implicit none
       integer(int32), intent(in) :: number
       integer(int32) :: c
       logical :: isPrime

        if (number <= 1) then
            isPrime = .false.
        else if (number <= 3) then
            isPrime = .true.
        else if (( mod(number, 2) == 0) .or. (mod(number, 3) == 0)) then
            isPrime = .false.
        else
            c = 5
            do while (c*c <= number)
                if ( (mod(number, c) == 0) .or. (mod(number, c+2) == 0) ) then
                    isPrime = .false.
                    return
                end if
                c = c + 6
            end do
            isPrime = .true.
        end if
    end function isNumberPrime

    function deltaTimeSeconds(startTime, endTime) result(deltaTime)
        use ISO_FORTRAN_ENV
        implicit none
        integer(int32), dimension(8), intent(in) :: startTime, endTime
        real(real32) :: deltaTime, rstartTime, rendTime

        rstartTime = (startTime(5)) * 60.0 ! Hours to minutes
        rstartTime = (rstartTime + startTime(6)) * 60.0 ! Minutes to seconds
        rstartTime = (rstartTime + startTime(7)) * 1e3 ! Seconds to milliseconds
        rstartTime = rstartTime + startTime(8) ! Add milliseconds
        rendTime = (endTime(5)) * 60.0 ! Hours to minutes
        rendTime = (rendTime + endTime(6)) * 60.0 ! Minutes to seconds
        rendTime = (rendTime + endTime(7)) * 1e3 ! Seconds to milliseconds
        rendTime = rendTime + endTime(8) ! Add milliseconds
        deltaTime = (rendTime - rstartTime)/1000.0
    end function deltaTimeSeconds

    subroutine countPrimes(minNumber, maxNumber)
        use ISO_FORTRAN_ENV

        implicit none
        integer(int32), intent(in) :: minNumber, maxNumber
        integer(int32) :: currentNum, primesCount
        integer(int32), dimension(8) :: startTime, endTime

        print *, 'Fortran 6'
        print *, 'Checking primes between ', minNumber, ' and ', maxNumber

        call date_and_time(values = startTime)

        primesCount = 0
        do currentNum = minNumber, maxNumber
            if (isNumberPrime(currentNum)) primesCount = primesCount + 1
        end do

        call date_and_time(values = endTime)

        print *, 'SingleThread : Found ', primesCount, &
                ' primes in ', deltaTimeSeconds(startTime, endTime), 's'
        print *

        return
    end subroutine countPrimes

end program primes
