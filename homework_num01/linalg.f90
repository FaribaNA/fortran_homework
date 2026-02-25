module linalg
  use types
  implicit none
contains

  ! read_matrix

  subroutine read_matrix(filename, A, b)
    character(len=*), intent(in) :: filename
    real(kind=rkind), dimension(:,:), allocatable, intent(out) :: A
    real(kind=rkind), dimension(:), allocatable, intent(out) :: b

    integer :: n, i, j, fileid, ios

    open(newunit=fileid, file=filename, status="old", action="read", iostat=ios)
    if (ios /= 0) then
      print *, "ERROR: file not found: ", trim(filename)
      stop
    end if

    read(fileid,*,iostat=ios) n
    if (ios /= 0 .or. n <= 0) then
      print *, "ERROR: bad n in file."
      stop
    end if

    allocate(A(n,n), b(n))

    do i = 1, n
      read(fileid,*,iostat=ios) (A(i,j), j=1,n), b(i)
      if (ios /= 0) then
        print *, "ERROR: bad row ", i
        stop
      end if
    end do

    close(fileid)
  end subroutine read_matrix


  ! debugging procedure printmtx

  subroutine printmtx(a)
  real(kind=rkind), dimension(:,:), intent(in) :: a
    integer :: i, n

    n = ubound(a,1)

    do i = 1, n
      print *, "row", i, "value", a(i,:)
    end do
  end subroutine printmtx


  ! gem : augmented matrix AB = (A|b), completed loop... upper triangular,
  ! backward substitution, debugging prints via call printmtx(...)

  subroutine gem(A, b, x)
  real(kind=rkind), dimension(:,:), intent(in) :: A
  real(kind=rkind), dimension(:),   intent(in) :: b
  real(kind=rkind), dimension(:),   allocatable, intent(out) :: x

    integer :: n, i, j
    real(kind=rkind), dimension(:,:), allocatable :: AB
    real(kind=rkind) :: s

    n = ubound(A,1)

    allocate(AB(n, n+1))
    AB(:,1:n) = A
    AB(:,n+1) = b

    ! debug: initial AB
    call printmtx(AB)

    ! forward elimination
    do j = 1, n-1
      if (AB(j,j) == 0.0_rkind) then
        print *, "ERROR: zero pivot (no pivoting)."
        stop 1
      end if

      do i = j+1, n
        AB(i,:) = AB(i,:) - AB(i,j)/AB(j,j) * AB(j,:)

        ! debug after each elimination step
        call printmtx(AB)
      end do
    end do

    ! backward substitution
    allocate(x(n))
    x = 0.0_rkind

    do i = n, 1, -1
      if (AB(i,i) == 0.0_rkind) then
        print *, "ERROR: zero diagonal in back substitution."
        stop 1
      end if

      s = 0.0_rkind
      if (i < n) s = sum(AB(i, i+1:n) * x(i+1:n))
      x(i) = (AB(i, n+1) - s) / AB(i,i)

      ! debug during backward substitution
      print *, "x(", i, ") = ", x(i)
    end do

  end subroutine gem

end module linalg
