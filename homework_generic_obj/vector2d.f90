module vector2d_mod
    use types
    implicit none
    private
    public :: vector2d, norm

    type :: vector2d
        real(kind=rkind) :: x, y
    end type vector2d

    interface norm
        module procedure norm_vector2d
    end interface norm

contains

    function norm_vector2d(v) result(val)
        type(vector2d), intent(in) :: v
        real(kind=rkind) :: val
        val = sqrt(v%x*v%x + v%y*v%y)
    end function norm_vector2d

end module vector2d_mod
