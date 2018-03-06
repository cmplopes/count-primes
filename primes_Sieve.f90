program sieve
 
    use ISO_FORTRAN_ENV

    implicit none
    integer, parameter :: i_max = 20000000
    integer :: i
    integer :: count = 0
    logical(kind=int8), dimension (:), allocatable :: is_prime
    integer, dimension(8) :: tstart, tend

    call date_and_time(values = tstart)

    allocate(is_prime(i_max+1))

    is_prime = .true.
    is_prime (1) = .false.
    !$omp parallel do private(i) shared(is_prime) num_threads(4)
    do i = 2, int (sqrt (real (i_max)))
        if  (is_prime (i)) is_prime (i * i : i_max : i) = .false.
    end do
    !$omp end parallel do
  
    !$OMP parallel do private(i) num_threads(4) reduction(+:count)
    do i = 1, i_max
        if (is_prime (i)) count = count + 1
    end do
    !$omp end parallel do

    deallocate(is_prime)

    call date_and_time(values = tend)

    print *, 'Primes between ', 0, ' and ', i_max
    print *, 'Sieve (ms)', count, 1000*delta_time(tstart, tend)

    return
    
contains 

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
 
end program sieve
