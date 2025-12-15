module shapes2d
    use types
    implicit none

    type, abstract :: shape
    contains
        procedure(area_ifc),      deferred :: area
        procedure(perimeter_ifc), deferred :: perimeter
    end type shape

    abstract interface
        function area_ifc(self) result(a)
            import :: shape, rkind
            class(shape), intent(in) :: self
            real(kind=rkind) :: a
        end function area_ifc

        function perimeter_ifc(self) result(p)
            import :: shape, rkind
            class(shape), intent(in) :: self
            real(kind=rkind) :: p
        end function perimeter_ifc
    end interface

    type, extends(shape) :: right_triangle
        real(kind=rkind) :: a, b
    contains
        procedure :: area      => right_triangle_area
        procedure :: perimeter => right_triangle_perimeter
    end type right_triangle

    type, extends(shape) :: rectangle
        real(kind=rkind) :: width, height
    contains
        procedure :: area      => rectangle_area
        procedure :: perimeter => rectangle_perimeter
    end type rectangle

    type, extends(shape) :: triangle_xy
        real(kind=rkind) :: x1, y1
        real(kind=rkind) :: x2, y2
        real(kind=rkind) :: x3, y3
    contains
        procedure :: area      => triangle_xy_area
        procedure :: perimeter => triangle_xy_perimeter
    end type triangle_xy

    type, extends(shape) :: quadrangle_xy
        real(kind=rkind) :: x1, y1
        real(kind=rkind) :: x2, y2
        real(kind=rkind) :: x3, y3
        real(kind=rkind) :: x4, y4
    contains
        procedure :: area      => quadrangle_xy_area
        procedure :: perimeter => quadrangle_xy_perimeter
    end type quadrangle_xy

contains

    function right_triangle_area(self) result(A)
        class(right_triangle), intent(in) :: self
        real(kind=rkind) :: A
        A = 0.5_rkind * self%a * self%b
    end function right_triangle_area

    function right_triangle_perimeter(self) result(P)
        class(right_triangle), intent(in) :: self
        real(kind=rkind) :: P
        P = self%a + self%b + sqrt(self%a*self%a + self%b*self%b)
    end function right_triangle_perimeter

    function rectangle_area(self) result(A)
        class(rectangle), intent(in) :: self
        real(kind=rkind) :: A
        A = self%width * self%height
    end function rectangle_area

    function rectangle_perimeter(self) result(P)
        class(rectangle), intent(in) :: self
        real(kind=rkind) :: P
        P = 2.0_rkind * (self%width + self%height)
    end function rectangle_perimeter

    function triangle_xy_area(self) result(A)
        class(triangle_xy), intent(in) :: self
        real(kind=rkind) :: A
        A = 0.5_rkind * abs( self%x1*(self%y2 - self%y3) + &
                             self%x2*(self%y3 - self%y1) + &
                             self%x3*(self%y1 - self%y2) )
    end function triangle_xy_area

    function triangle_xy_perimeter(self) result(P)
        class(triangle_xy), intent(in) :: self
        real(kind=rkind) :: P
        real(kind=rkind) :: d12, d23, d31

        d12 = sqrt( (self%x2 - self%x1)**2 + (self%y2 - self%y1)**2 )
        d23 = sqrt( (self%x3 - self%x2)**2 + (self%y3 - self%y2)**2 )
        d31 = sqrt( (self%x1 - self%x3)**2 + (self%y1 - self%y3)**2 )

        P = d12 + d23 + d31
    end function triangle_xy_perimeter

    function quadrangle_xy_area(self) result(A)
        class(quadrangle_xy), intent(in) :: self
        real(kind=rkind) :: A
        real(kind=rkind) :: A1, A2

        A1 = 0.5_rkind * abs( self%x1*(self%y2 - self%y3) + &
                              self%x2*(self%y3 - self%y1) + &
                              self%x3*(self%y1 - self%y2) )

        A2 = 0.5_rkind * abs( self%x1*(self%y3 - self%y4) + &
                              self%x3*(self%y4 - self%y1) + &
                              self%x4*(self%y1 - self%y3) )

        A = A1 + A2
    end function quadrangle_xy_area

    function quadrangle_xy_perimeter(self) result(P)
        class(quadrangle_xy), intent(in) :: self
        real(kind=rkind) :: P
        real(kind=rkind) :: d12, d23, d34, d41

        d12 = sqrt( (self%x2 - self%x1)**2 + (self%y2 - self%y1)**2 )
        d23 = sqrt( (self%x3 - self%x2)**2 + (self%y3 - self%y2)**2 )
        d34 = sqrt( (self%x4 - self%x3)**2 + (self%y4 - self%y3)**2 )
        d41 = sqrt( (self%x1 - self%x4)**2 + (self%y1 - self%y4)**2 )

        P = d12 + d23 + d34 + d41
    end function quadrangle_xy_perimeter

end module shapes2d
