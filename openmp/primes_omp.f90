program primos

    use ISO_FORTRAN_ENV
    
    implicit none
    character(len=32) :: a1, a2
    integer(int32) :: minprime  
    integer(int32) :: maxprime  
    integer :: count

    count = command_argument_count()
    if (count >= 2) then 
        call get_command_argument(1, a1)
        call get_command_argument(2, a2)
        read(a1,*) minprime
        read(a2,*) maxprime
    else
        print '(a,/)', 'Unrecognized command-line option'
        call print_help()
        print '(a,/)', 'using: minprime=0 and maxprime=20000000'
        minprime = 0
        maxprime = 20000000
    end if
    call primes(minprime, maxprime)

    return
    
contains 

    function isPrime(num) result(ok)
       use ISO_FORTRAN_ENV
       implicit none
       integer(int32), intent(in) :: num
       integer(int32) :: c
       logical :: ok

        if (num <= 1) then 
            ok = .false.
        else if (num <= 3) then  
            ok = .true.
        else if (( mod(num, 2) == 0) .or. (mod(num, 3) == 0)) then
            ok = .false.
        else
            c = 5
            do while (c*c <= num)
                if ( (mod(num, c) == 0) .or. (mod(num, c+2) == 0) ) then
                    ok = .false.
                    return
                end if
                c = c + 6
            end do
            ok = .true.
        end if
    end function isPrime

    function delta_time(tTime1, tTime2) result(rTime)
        use ISO_FORTRAN_ENV
        implicit none
        integer(int32), dimension(8), intent(in) :: tTime1, tTime2
        real(real32) :: rTime, rTime1, rTime2

        rTime1 = (tTime1(5)) * 60. ! Hours to minutes
        rTime1 = (rTime1 + tTime1(6)) * 60. ! Minutes to seconds
        rTime1 = (rTime1 + tTime1(7)) * 1e3 ! Seconds to milliseconds
        rTime1 = rTime1 + tTime1(8) ! Add milliseconds
        rTime2 = (tTime2(5)) * 60. ! Hours to minutes
        rTime2 = (rTime2 + tTime2(6)) * 60. ! Minutes to seconds
        rTime2 = (rTime2 + tTime2(7)) * 1e3 ! Seconds to milliseconds
        rTime2 = rTime2 + tTime2(8) ! Add milliseconds
        rTime = (rtime2 - rtime1)/1000.
    end function delta_time

    subroutine primes(minprime, maxprime)
        use ISO_FORTRAN_ENV

        implicit none
        integer(int32), intent(in) :: minprime, maxprime
        integer(int32) :: i, cont = 0
        integer(int32), dimension(8) :: tstart, tend

        cont = 0
        print *, 'Fortran with OpenMP'
        
        call date_and_time(values = tstart)
        
        !$OMP parallel do private (I) num_threads(4) reduction(+:cont)   
        do i = minprime, maxprime
            if (isPrime(i)) cont = cont + 1
        end do
        
        call date_and_time(values = tend)

        print *, 'Primes between ', minprime, ' and ', maxprime
        print *, 'Found ', cont, 'primes in ', delta_time(tstart, tend), 's'
        print *

        return
    end subroutine primes
    
    subroutine print_help()
        print '(a)', 'usage: primesomp [minprime] [maxprime]'
    end subroutine print_help

end program primos
