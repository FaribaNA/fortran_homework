module geom2d
  use types
  implicit none
  private
  public :: carea, sarea, rectap

contains

  function carea(radius) result(ci_area)
    real(kind=rkind), intent(in) :: radius
    real(kind=rkind) :: ci_area
    real(kind=rkind) :: pi
    pi = 4.0_rkind * atan(1.0_rkind)
    ci_area = pi * radius**2
  end function carea

  function sarea(side) result(sq_area)
    real(kind=rkind), intent(in) :: side
    real(kind=rkind):: sq_area
    sq_area = side * side
  end function sarea

  subroutine rectap(length, width, A,P)
    real(kind=rkind), intent(in) :: length, width
    real(kind=rkind), intent(out) :: A, P
    A = length * width
    P = 2.0_rkind*(length + width)
  end subroutine rectap

end module geom2d
