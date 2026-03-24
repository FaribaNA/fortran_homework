module linalg
    use types
    implicit none

contains

    subroutine read_matrix(filename, A, b)
        character(len = *), intent(in) :: filename
        real(kind = rkind), dimension(:, :), allocatable, intent(out) :: A
        real(kind = rkind), dimension(:), allocatable, intent(out) :: b
        integer :: n, i, j, fileid, ios

        open(newunit = fileid, file = filename, status = "old", action = "read", iostat = ios)
        if (ios /= 0) then
            print *, "ERROR: file not found: ", trim(filename)
            stop
        end if

        read(fileid, *, iostat = ios) n
        if (ios /= 0 .or. n <= 0) then
            print *, "ERROR: bad n in file."
            stop
        end if

        allocate(A(n, n), b(n))

        do i = 1, n
            read(fileid, *, iostat = ios) (A(i, j), j = 1, n), b(i)
            if (ios /= 0) then
                print *, "ERROR: bad row ", i
                stop
            end if
        end do

        close(fileid)
    end subroutine read_matrix

    subroutine gem(A, b, x)
        implicit none

        real(kind = rkind), dimension(:, :), intent(in) :: A
        real(kind = rkind), dimension(:), intent(in) :: b
        real(kind = rkind), dimension(:), allocatable, intent(out) :: x
        integer :: n, i, k, itmp
        real(kind = rkind), dimension(:, :), allocatable :: AB
        real(kind = rkind), dimension(:), allocatable :: xtmp
        integer, dimension(:), allocatable :: perm
        integer :: pivotloc(2)
        real(kind = rkind) :: factor, s

        n = size(b)

        allocate(AB(n, n + 1), x(n), xtmp(n), perm(n))

        AB(:, 1:n) = A
        AB(:, n + 1) = b

        perm = [(i, i = 1, n)]

        do k = 1, n - 1

            !full pivot
            pivotloc = maxloc(abs(AB(k:n, k:n))) + k - 1

            !column swap
            if (pivotloc(2) /= k) then
                AB(:, [k, pivotloc(2)]) = AB(:, [pivotloc(2), k])

                itmp = perm(k)
                perm(k) = perm(pivotloc(2))
                perm(pivotloc(2)) = itmp
            end if

            !row swap
            if (pivotloc(1) /= k) then
                AB([k, pivotloc(1)], :) = AB([pivotloc(1), k], :)
            end if

            !elimination
            do i = k + 1, n
                factor = AB(i, k) / AB(k, k)

                AB(i, k:n + 1) = AB(i, k:n + 1) - factor * AB(k, k:n + 1)
            end do
        end do

        ! back substitution
        do i = n, 1, -1
            s = 0.0_rkind
            if (i < n) s = sum(AB(i, i + 1:n) * x(i + 1:n))
            x(i) = (AB(i, n + 1) - s) / AB(i, i)
        end do

        !reorder solution
        xtmp = x
        x(perm) = xtmp

    end subroutine gem

    subroutine residual_vect(A, x, b, r)
        real(kind = rkind), dimension(:, :), intent(in) :: A
        real(kind = rkind), dimension(:), intent(in) :: x
        real(kind = rkind), dimension(:), intent(in) :: b
        real(kind = rkind), dimension(:), allocatable, intent(out) :: r

        allocate(r(size(b)))
        r = matmul(A, x) - b
    end subroutine residual_vect

    subroutine residual_max(r, max_resi)
        real(kind = rkind), dimension(:), intent(in) :: r
        real(kind = rkind), intent(out) :: max_resi

        max_resi = maxval(abs(r))
    end subroutine residual_max

    subroutine hilbert_matrix(n, A, b)
        integer, intent(in) :: n
        real(kind = rkind), dimension(:, :), allocatable, intent(out) :: A
        real(kind = rkind), dimension(:), allocatable, intent(out) :: b

        integer :: i, j

        allocate(A(n, n), b(n))

        do i = 1, n
            do j = 1, n
                A(i, j) = 1.0_rkind / real(i + j - 1, rkind)
            end do
        end do

        do i = 1, n
            b(i) = sum(A(i, :))
        end do
    end subroutine hilbert_matrix

    subroutine generalized_hilbert_matrix(n, c, d, A, b)
        integer, intent(in) :: n
        real(kind = rkind), intent(in) :: c, d
        real(kind = rkind), dimension(:, :), allocatable, intent(out) :: A
        real(kind = rkind), dimension(:), allocatable, intent(out) :: b

        integer :: i, j

        allocate(A(n, n), b(n))

        do i = 1, n
            do j = 1, n
                A(i, j) = 1.0_rkind / (c * real(i, rkind) + d * real(j, rkind) - real(j, rkind))
            end do
        end do

        do i = 1, n
            b(i) = sum(A(i, :))
        end do
    end subroutine generalized_hilbert_matrix

    subroutine ones_vect(n, x_exact)
        integer, intent(in) :: n
        real(kind = rkind), dimension(:), allocatable, intent(out) :: x_exact

        allocate(x_exact(n))
        x_exact = 1.0_rkind
    end subroutine ones_vect

end module linalg
