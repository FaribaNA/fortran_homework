module integration
  use types
  implicit none

contains

  function f(x) result(y)
    real(rkind), intent(in) :: x
    real(rkind) :: y

    y = exp(1.0_rkind / x)

  end function f


  subroutine gauss_points(order, t, w)
    integer, intent(in) :: order
    real(rkind), intent(out) :: t(6), w(6)

    t = 0.0_rkind
    w = 0.0_rkind

    if (order == 1) then

      t(1) = 0.0_rkind
      w(1) = 2.0_rkind

    else if (order == 2) then

      t(1) = -0.577350269189626_rkind
      t(2) =  0.577350269189626_rkind

      w(1) = 1.0_rkind
      w(2) = 1.0_rkind

    else if (order == 3) then

      t(1) = -0.774596669241483_rkind
      t(2) =  0.0_rkind
      t(3) =  0.774596669241483_rkind

      w(1) = 0.555555555555556_rkind
      w(2) = 0.888888888888889_rkind
      w(3) = 0.555555555555556_rkind

    else if (order == 4) then

      t(1) = -0.861136311594053_rkind
      t(2) = -0.339981043584856_rkind
      t(3) =  0.339981043584856_rkind
      t(4) =  0.861136311594053_rkind

      w(1) = 0.347854845137454_rkind
      w(2) = 0.652145154862546_rkind
      w(3) = 0.652145154862546_rkind
      w(4) = 0.347854845137454_rkind

    else if (order == 5) then

      t(1) = -0.906179845938664_rkind
      t(2) = -0.538469310105683_rkind
      t(3) =  0.0_rkind
      t(4) =  0.538469310105683_rkind
      t(5) =  0.906179845938664_rkind

      w(1) = 0.236926885056189_rkind
      w(2) = 0.478628670499366_rkind
      w(3) = 0.568888888888889_rkind
      w(4) = 0.478628670499366_rkind
      w(5) = 0.236926885056189_rkind

    else if (order == 6) then

      t(1) = -0.932469514203152_rkind
      t(2) = -0.661209386466265_rkind
      t(3) = -0.238619186083197_rkind
      t(4) =  0.238619186083197_rkind
      t(5) =  0.661209386466265_rkind
      t(6) =  0.932469514203152_rkind

      w(1) = 0.171324492379170_rkind
      w(2) = 0.360761573048139_rkind
      w(3) = 0.467913934572691_rkind
      w(4) = 0.467913934572691_rkind
      w(5) = 0.360761573048139_rkind
      w(6) = 0.171324492379170_rkind

    end if

  end subroutine gauss_points


  function gauss_integral(a, b, order) result(ans)
    real(rkind), intent(in) :: a, b
    integer, intent(in) :: order
    real(rkind) :: ans
    real(rkind) :: t(6), w(6)
    real(rkind) :: x
    real(rkind) :: part
    real(rkind) :: sum_value
    integer :: i

    call gauss_points(order, t, w)

    sum_value = 0.0_rkind

    do i = 1, order

      x = 0.5_rkind * (a + b) + 0.5_rkind * (b - a) * t(i)

      part = w(i) * f(x)

      sum_value = sum_value + part

    end do

    ans = 0.5_rkind * (b - a) * sum_value

  end function gauss_integral


  function trapezoid_integral(a, b, n) result(ans)
    real(rkind), intent(in) :: a, b
    integer, intent(in) :: n
    real(rkind) :: ans
    real(rkind) :: h
    real(rkind) :: x_left
    real(rkind) :: x_right
    real(rkind) :: area
    integer :: i

    h = (b - a) / real(n, rkind)

    ans = 0.0_rkind

    do i = 1, n

      x_left = a + real(i - 1, rkind) * h
      x_right = a + real(i, rkind) * h

      area = 0.5_rkind * h * (f(x_left) + f(x_right))

      ans = ans + area

    end do

  end function trapezoid_integral

end module integration
