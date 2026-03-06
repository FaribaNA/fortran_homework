module recurrence
    use types
    implicit none

contains

subroutine single_precision(nmax)

    integer, intent(in) :: nmax
    real(rskind) :: current_val, prev_val
    real(rskind) :: inv_e
    integer :: n

    inv_e = exp(-1.0_rskind)

    current_val = 1.0_rskind - inv_e
    prev_val = current_val

    do n = 1, nmax

        current_val = n * prev_val - inv_e

        print*, 'step =', n, ' value =', current_val

        if (current_val <= 0.0_rskind) then
             print*, 'algorithm failed at n =', n
            exit
        end if

        if (current_val >= prev_val) then
             print*, 'algorithm failed at n =', n
            exit
        end if

        prev_val = current_val

    end do

end subroutine single_precision



subroutine double_precision(nmax)

    integer, intent(in) :: nmax
    real(rdkind) :: current_val, prev_val
    real(rdkind) :: inv_e
    integer :: n

    inv_e = exp(-1.0_rdkind)

    current_val = 1.0_rdkind - inv_e
    prev_val = current_val

    do n = 1, nmax

        current_val = n * prev_val - inv_e

         print*, 'step =', n, ' value =', current_val

        if (current_val <= 0.0_rdkind) then
             print*, 'algorithm failed at n =', n
            exit
        end if

        if (current_val >= prev_val) then
             print*, 'algorithm failed at n =', n
            exit
        end if

        prev_val = current_val

    end do

end subroutine double_precision



subroutine quad_precision(nmax)

    integer, intent(in) :: nmax
    real(rqkind) :: current_val, prev_val
    real(rqkind) :: inv_e
    integer :: n

    inv_e = exp(-1.0_rqkind)

    current_val = 1.0_rqkind - inv_e
    prev_val = current_val

    do n = 1, nmax

        current_val = n * prev_val - inv_e

         print*, 'step =', n, ' value =', current_val

        if (current_val <= 0.0_rqkind) then
             print*, 'algorithm failed at n =', n
            exit
        end if

        if (current_val >= prev_val) then
             print*, 'algorithm failed at n =', n
            exit
        end if

        prev_val = current_val

    end do

end subroutine quad_precision

end module recurrence
