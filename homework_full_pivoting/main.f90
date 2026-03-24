program main
    use types
    use linalg
    implicit none

    real(kind = rkind), dimension(:, :), allocatable :: A
    real(kind = rkind), dimension(:), allocatable :: b, x, r, x_exact
    real(kind = rkind) :: max_resi, err, l2_resi
    real(kind = rkind), parameter :: c13 = 0.94_rkind, d13 = 0.86_rkind
    real(kind = rkind), parameter :: error_tol = 1.0e-6_rkind
    integer :: i, n
    integer :: file_h, file_g
    integer :: first_unstable_h, first_unstable_g

    first_unstable_h = 0
    first_unstable_g = 0

    open(newunit = file_h, file = "hilbert_results.txt", status = "replace", action = "write")
    open(newunit = file_g, file = "generalized_hilbert_results.txt", status = "replace", action = "write")

    write(file_h, *) "n error residual_max"
    write(file_g, *) "n error residual_max"

    print *, "Given matrix: "

    call read_matrix("matrix.txt", A, b)
    call gem(A, b, x)

    print *, "x = "
    do i = 1, size(x)
        print *, x(i)
    end do

    call residual_vect(A, x, b, r)
    call residual_max(r, max_resi)
    l2_resi = sqrt(sum(r**2))

    do i = 1, size(r)
        print *, r(i)
    end do

    print *, "max(|r|) = ", max_resi
    print *, "||r||_2 = ", l2_resi

    deallocate(A, b, x, r)

    print *, "Hilbert: "
    print *, "          n error                       residual_max"

    do n = 1, 70
        call hilbert_matrix(n, A, b)
        call ones_vect(n, x_exact)
        call gem(A, b, x)

        err = maxval(abs(x - x_exact))

        if (first_unstable_h == 0 .and. err > error_tol) then
            first_unstable_h = n
        end if

        call residual_vect(A, x, b, r)
        call residual_max(r, max_resi)

        print *, n, err, max_resi
        write(file_h, *) n, err, max_resi

        deallocate(A, b, x, r, x_exact)
    end do

    print *, "Generalized Hilbert (student 13) Fariba Naghizadeh: "
    print *, "c = ", c13, " d = ", d13
    print *, "          n error                       residual_max"

    do n = 2, 70
        call generalized_hilbert_matrix(n, c13, d13, A, b)
        call ones_vect(n, x_exact)
        call gem(A, b, x)

        err = maxval(abs(x - x_exact))

        if (first_unstable_g == 0 .and. err > error_tol) then
            first_unstable_g = n
        end if

        call residual_vect(A, x, b, r)
        call residual_max(r, max_resi)

        print *, n, err, max_resi
        write(file_g, *) n, err, max_resi

        deallocate(A, b, x, r, x_exact)
    end do

    print *, "failure summary: "

    if (first_unstable_h == 0) then
        print *, "Hilbert: stable up to n = 70"
    else
        print *, "Hilbert becomes unstable at n = ", first_unstable_h
    end if

    if (first_unstable_g == 0) then
        print *, "Generalized Hilbert: stable up to n = 70"
    else
        print *, "Generalized Hilbert becomes unstable at n = ", first_unstable_g
    end if

    close(file_h)
    close(file_g)

end program main
