program main
  use types
  use linalg
  implicit none

  real(kind=rkind),dimension(:,:), allocatable :: A
  real(kind=rkind),dimension(:), allocatable :: b , x
  call read_matrix("matrix.txt", A, b)
  call gem(A, b, x)

  print *, "Final x:"
  print *, x

  print *, "residual norm = ", sqrt(sum((matmul(A,x)-b)**2))

end program main
