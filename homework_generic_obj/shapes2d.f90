module shapes2d

    use types
    implicit none
    private
    public :: right_triangle, rectangle, triangle_xy, quadrangle_xy, area


    type :: right_triangle
        real(kind=rkind) :: a, b
    end type right_triangle


    type :: rectangle
        real(kind=rkind) :: width, height
    end type rectangle


    type :: triangle_xy
        real(kind=rkind) :: x1, y1
        real(kind=rkind) :: x2, y2
        real(kind=rkind) :: x3, y3
    end type triangle_xy


    type :: quadrangle_xy
        real(kind=rkind) :: x1, y1
        real(kind=rkind) :: x2, y2
        real(kind=rkind) :: x3, y3
        real(kind=rkind) :: x4, y4
    end type quadrangle_xy


    interface area
        module procedure area_right_triangle
        module procedure area_rectangle
        module procedure area_triangle_xy
        module procedure area_quadrangle_xy
    end interface area


contains


    function area_right_triangle(t) result(a)
        type(right_triangle), intent(in) :: t
        real(kind=rkind) :: a
        a = 0.5_rkind * t%a * t%b
    end function area_right_triangle


    function area_rectangle(r) result(a)
        type(rectangle), intent(in) :: r
        real(kind=rkind) :: a
        a = r%width * r%height
    end function area_rectangle


    function area_triangle_xy(t) result(a)
        type(triangle_xy), intent(in) :: t
        real(kind=rkind) :: a
        a = 0.5_rkind * abs( t%x1*(t%y2 - t%y3) + &
                             t%x2*(t%y3 - t%y1) + &
                             t%x3*(t%y1 - t%y2) )
    end function area_triangle_xy


    function area_quadrangle_xy(q) result(a)
        type(quadrangle_xy), intent(in) :: q
        real(kind=rkind) :: a
        real(kind=rkind) :: a1, a2

        a1 = 0.5_rkind * abs( q%x1*(q%y2 - q%y3) + &
                              q%x2*(q%y3 - q%y1) + &
                              q%x3*(q%y1 - q%y2) )

        a2 = 0.5_rkind * abs( q%x1*(q%y3 - q%y4) + &
                              q%x3*(q%y4 - q%y1) + &
                              q%x4*(q%y1 - q%y3) )

        a = a1 + a2
    end function area_quadrangle_xy


end module shapes2d
