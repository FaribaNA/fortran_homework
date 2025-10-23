program main
  use types
  use geom2d
  use mathfun
  implicit none

  real(kind=rkind) :: v1, v2
  real(kind=rkind) :: total
  real(kind=rkind) :: area_cir
  real(kind=rkind) :: area_sq

  print*, 'Enter two real numbers (use space or Enter to separate them):'
  read(*,*) v1, v2

  total = add(v1, v2)
  print *, "Sum of the two real numbers is:", total

  call swap(v1, v2)
  print *, 'After swapping: v1 =', v1, ' v2 =', v2

  !now v1 and v2 are swapped, so circle area uses the new v1 value
  area_cir = carea(v1)
  print *, "Area of circle (radius =", v1, ") =", area_cir

  area_sq = sarea(v2)
  print *, "Area of square (side =", v2, ") =", area_sq

end program main
