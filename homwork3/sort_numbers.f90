module sortnumbers
    use types
    implicit none

    public :: sorthighlow, sortlowhigh, checkinputs
    public :: sorthighlow_inplace, sortlowhigh_inplace

    contains

    logical function checkinputs(array_in, array_out) result(success)
        use types
        implicit none

        real(kind=rkind), dimension(:), allocatable, intent(in)    :: array_in
        real(kind=rkind), dimension(:), allocatable, intent(inout) :: array_out

        if (.not. allocated(array_in)) then
            success = .false.
            return
        end if

       if (.not. allocated(array_out)) then
           allocate(array_out(size(array_in)))
       else
           if (size(array_out) /= size(array_in)) then
               deallocate(array_out)
               allocate(array_out(size(array_in)))
          end if
      endif

      success = .true.

    end function checkinputs


! NON-DESTRUCTIVE DESCENDING

    subroutine sorthighlow(array_in, array_out, success )
        use types
        implicit none

        real(kind=rkind), dimension(:), allocatable, intent(in) :: array_in
        real(kind=rkind), dimension(:), allocatable, intent(out) :: array_out

        integer(kind=ikind) :: i , fin
        integer(kind=ikind), dimension(1) :: pos
        real(kind=rkind) :: tmp
        logical :: success

        if (.not. checkinputs(array_in, array_out)) then
            error stop "Incorrect inputs"
        endif

        array_out = array_in
        fin = size(array_out,1)

        do i = 1, fin
            pos = maxloc(array_out(i:))
            pos(1) = pos(1) + i - 1

            tmp = array_out(i)
            array_out(i) = array_out(pos(1))
            array_out(pos(1)) = tmp
        end do
    end subroutine sorthighlow


! NON-DESTRUCTIVE ASCENDING

    subroutine sortlowhigh(array_in, array_out, success)
        use types
        implicit none

        real(kind=rkind), dimension(:), allocatable, intent(in) :: array_in
        real(kind=rkind), dimension(:), allocatable, intent(out) :: array_out

        integer(kind=ikind) :: i ,fin
        integer(kind=ikind), dimension(1) :: pos
        real(kind=rkind) :: tmp
        logical :: success

        if (.not. checkinputs(array_in, array_out)) then
            error stop "Incorrect inputs"
        endif

        array_out = array_in
        fin = size(array_out,1)

        do i = 1, fin
            pos = minloc(array_out(i:))
            pos(1) = pos(1) + i - 1

            tmp = array_out(i)
            array_out(i) = array_out(pos(1))
            array_out(pos(1)) = tmp
        end do
    end subroutine sortlowhigh

! DESTRUCTIVE DESCENDING

    subroutine sorthighlow_inplace(array_in)
        use types
        implicit none

        real(kind=rkind), dimension(:), intent(inout) :: array_in
        integer(kind=ikind) :: i, fin
        integer(kind=ikind), dimension(1) :: pos
        real(kind=rkind) :: tmp
        fin = size(array_in,1)
        do i = 1, fin
            pos = maxloc(array_in(i:))
            pos(1) = pos(1) + i - 1

            tmp = array_in(i)
            array_in(i) = array_in(pos(1))
            array_in(pos(1)) = tmp
        end do
    end subroutine sorthighlow_inplace

! DESTRUCTIVE ASCENDING

    subroutine sortlowhigh_inplace(array_in)
        use types
        implicit none

        real(kind=rkind), dimension(:), intent(inout) :: array_in

        integer(kind=ikind) :: i, fin
        integer(kind=ikind), dimension(1) :: pos
        real(kind=rkind) :: tmp
        fin = size(array_in,1)


        do i = 1 , fin
            pos = minloc(array_in(i:))
            pos(1) = pos(1) + i - 1

            tmp = array_in(i)
            array_in(i) = array_in(pos(1))
            array_in(pos(1)) = tmp
        end do
    end subroutine sortlowhigh_inplace




!permut method

    subroutine permut_max(array_in)

        real(kind=rkind), dimension(:), intent(in) :: array_in
        real(kind=rkind), dimension(:), allocatable :: p
        integer(kind=ikind) :: fin, i
        real(kind=rkind) :: tmp
        integer(kind=ikind), dimension(1) :: pos_arr !maxloc returns rank-1 array
        integer(kind=ikind) :: pos ! index

        fin = size(array_in)
        allocate(p(fin))
        p = array_in

        do i = 1, fin - 1
            pos_arr = maxloc(p(i:fin))
            pos = pos_arr(1) + i - 1

            ! Swap the current element
            tmp = p(pos)
            p(pos) = p(i)
            p(i) = tmp
        end do

        print *, "Permutation (high → low): ", p

    end subroutine permut_max




    subroutine permut_min(array_in)

        real(kind=rkind), dimension(:), intent(in) :: array_in
        real(kind=rkind), dimension(:), allocatable :: p
        integer(kind=ikind) :: fin, i
        real(kind=rkind) :: tmp
        integer(kind=ikind), dimension(1) :: pos_arr   ! minloc returns rank-1 array
        integer(kind=ikind) :: pos

        fin = size(array_in)
        allocate(p(fin))
        p = array_in

        do i = 1, fin - 1
            pos_arr = minloc(p(i:fin))
            pos = pos_arr(1) + i - 1

            tmp = p(pos)
            p(pos) = p(i)
            p(i) = tmp
        end do

        print *, "Permutation (low → high): ", p

    end subroutine permut_min


end module sortnumbers
