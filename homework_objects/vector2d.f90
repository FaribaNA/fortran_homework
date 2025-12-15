module vector2d_mod
    use types
    implicit none

    type :: vector2d
        real(kind=rkind) :: x
        real(kind=rkind) :: y
    contains
        procedure :: norm => vector2d_norm
        procedure :: sum  => vector2d_sum
    end type vector2d

contains

    function vector2d_norm(self) result(val)
        class(vector2d), intent(in) :: self
        real(kind=rkind) :: val
        val = sqrt(self%x*self%x + self%y*self%y)
    end function vector2d_norm

    function vector2d_sum(self, other) result(vout)
        class(vector2d), intent(in) :: self
        class(vector2d), intent(in) :: other
        type(vector2d) :: vout
        vout%x = self%x + other%x
        vout%y = self%y + other%y
    end function vector2d_sum

end module vector2d_mod
