module mathfun
  use types
  implicit none
  private
  public :: add, swap

contains

  function add(a, b) result(res)
    real(kind=rkind), intent(in) :: a, b
    real(kind=rkind) :: res
    res = a + b
  end function add

  subroutine swap(x , y)
    real(kind=rkind), intent(inout) :: x, y
    !temporary variable used to store x value during swap
    real(kind=rkind) :: hold
    hold = x
    x = y
    y = hold
  end subroutine swap

end module mathfun
