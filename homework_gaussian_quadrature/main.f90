program main
  use types
  use integration
  implicit none

  real(rkind) :: a, b
  real(rkind) :: g(6)
  real(rkind) :: trap
  real(rkind) :: diff
  real(rkind) :: tol
  integer :: i
  integer :: n
  integer :: best_order

  a = 1.0_rkind
  b = 2.5_rkind

  tol = 1.0e-5_rkind

  print *, 'Numerical integration'
  print *, 'Name: Fariba'
  print *, 'Integral: exp(1/x) from 1 to 2.5'
  print *, ' '

  print *, 'Gaussian quadrature'
  print *, 'order        integral             difference'

  do i = 1, 6

    g(i) = gauss_integral(a, b, i)

    if (i == 1) then
      print '(i3, 5x, f18.12, 5x, a)', i, g(i), '-'
    else
      diff = abs(g(i) - g(i - 1))
      print '(i3, 5x, f18.12, 5x, es12.4)', i, g(i), diff
    end if

  end do

  best_order = 6

  do i = 2, 6

    if (abs(g(i) - g(i - 1)) < tol) then
      best_order = i
      exit
    end if

  end do

  print *, ' '
  print *, 'Selected Gaussian order:', best_order
  print *, 'Gaussian result:', g(best_order)
  print *, 'Gaussian function calls:', best_order
  print *, ' '
  n = best_order - 1
  trap = trapezoid_integral(a, b, n)

  print *, 'Trapezoid with the same number of function calls'
  print *, 'n panels:', n
  print *, 'Trapezoid function calls:', n + 1
  print *, 'Trapezoid result:', trap
  print *, 'Error compared with Gaussian:', abs(trap - g(best_order))
  print *, ' '
  print *, 'Trapezoidal method'
  print *, 'n panels    function calls       integral             error'

  n = 1

  do

    trap = trapezoid_integral(a, b, n)

    print '(i6, 8x, i6, 8x, f18.12, 5x, es12.4)', &
      n, n + 1, trap, abs(trap - g(best_order))

    if (abs(trap - g(best_order)) < tol) exit

    n = n * 2

  end do

  print *, ' '
  print *, 'Comparison'
  print *, 'Gaussian function calls  =', best_order
  print *, 'Trapezoid function calls =', n + 1

end program main
