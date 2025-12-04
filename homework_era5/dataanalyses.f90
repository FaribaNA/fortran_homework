module dataanalyses
    use types
    implicit none
    public :: diff1, correct_era5_daily_cum
contains

    subroutine diff1(x, dx)
        real(kind=rkind), dimension(:), intent(in)  :: x
        real(kind=rkind), dimension(:), intent(out) :: dx

        integer(kind=ikind) :: n, i
        ! n = the number of the elements in the array x.
        n = size(x)

        if (size(dx) /= n) then
            print *, 'diff1: input and output arrays must have same size.'
            stop
        end if

        if (n >= 1_ikind) then
            dx(1) = x(1)
        end if

        do i = 2_ikind, n
            dx(i) = x(i) - x(i - 1_ikind)
        end do

    end subroutine diff1

    subroutine correct_era5_daily_cum(tp_cum, e_cum, tp_inc, e_inc)
        real(kind=rkind), intent(in)  :: tp_cum(:)
        real(kind=rkind), intent(in)  :: e_cum(:)
        real(kind=rkind), intent(out) :: tp_inc(:)
        real(kind=rkind), intent(out) :: e_inc(:)

        integer(kind=ikind) :: n, i, hrs
        real(kind=rkind), allocatable :: tpdiff(:)
        real(kind=rkind), allocatable :: evapdiff(:)

        n = size(tp_cum)

        if (size(e_cum) /= n .or. size(tp_inc) /= n .or. size(e_inc) /= n) then
            print *, 'correct_era5_daily_cum: array sizes must match.'
            stop
        end if

        allocate(tpdiff(n))
        allocate(evapdiff(n))

        call diff1(tp_cum, tpdiff)
        call diff1(e_cum,  evapdiff)

        hrs = 0_ikind

        do i = 1_ikind, n
            !update the hour counter (1...24) and reset at the end of the day
            hrs = hrs + 1_ikind

            if (hrs == 24_ikind) hrs = 0_ikind

            ! At the first hour of the day (00:00 in Era5) use the cumulative value
            if (hrs == 1_ikind) then
                tp_inc(i) = tp_cum(i)
                e_inc(i)  = e_cum(i)
            else
                ! For other hours, use the first differences
                tp_inc(i) = tpdiff(i)
                e_inc(i)  = evapdiff(i)
            end if

            ! Clip small negative precipitation and positive evaporation
            if (tp_inc(i) < 0.0_rkind) tp_inc(i) = 0.0_rkind
            if (e_inc(i)  > 0.0_rkind) e_inc(i)  = 0.0_rkind

        end do

        deallocate(tpdiff)
        deallocate(evapdiff)

    end subroutine correct_era5_daily_cum

end module dataanalyses
