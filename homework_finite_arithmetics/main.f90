program numeric

    use types
    use recurrence
    implicit none

    integer :: i
    integer :: nmax_list(3)

    nmax_list = [20, 50, 100]

    print *, 'SINGLE PRECISION'

    do i = 1, 3
        print *, 'nmax = ', nmax_list(i)
        call single_precision(nmax_list(i))
    end do



    print *, 'DOUBLE PRECISION'

    do i = 1, 3
        print *, 'nmax = ', nmax_list(i)
        call double_precision(nmax_list(i))
    end do



    print *, 'QUAD PRECISION'

    do i = 1, 3
        print *, 'nmax = ', nmax_list(i)
        call quad_precision(nmax_list(i))
    end do

end program numeric
