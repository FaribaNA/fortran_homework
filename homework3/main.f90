program main
    use types
    use sortnumbers
    implicit none

    real(kind=rkind), dimension(:), allocatable :: array_in, array_out
    logical :: valid
    allocate(array_in(5))
    array_in = [-5.0_rkind, 11.0_rkind, 123.0_rkind, -4239.0_rkind, 26000.0_rkind]



    valid= checkinputs(array_in,array_out)

! Non-destructive descendin
    call sorthighlow(array_in, array_out, valid)
    print *, "Original input:   ", array_in
    print *, "Sorted (highlow):    ", array_out


! Non-destructive ascending
    call sortlowhigh(array_in, array_out, valid)
    print *, "Original input:   ", array_in
    print *, "Sorted (lowhigh):     ", array_out


! In-place ascending
    print *, "Before in-place lowhigh: ", array_in
    call sortlowhigh_inplace(array_in)
    print *, "After in-place lowhigh:  ", array_in

! In-place descending
    print *, "Before in-place highlow:", array_in
    call sorthighlow_inplace(array_in)
    print *, "After in-place highlow: ", array_in

    print *, "Before permut_max:", array_in
    call permut_max(array_in)



    print *, "Before permut_min:", array_in
    call permut_min(array_in)


end program main
