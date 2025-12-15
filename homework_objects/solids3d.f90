module solids3d
    use types
    implicit none

    type, abstract :: solid
    contains
        procedure(volume_ifc), deferred :: volume
    end type solid

    abstract interface
        function volume_ifc(self) result(v)
            import :: solid, rkind
            class(solid), intent(in) :: self
            real(kind=rkind) :: v
        end function volume_ifc
    end interface

    type, extends(solid) :: tetrahedron_xyz
        real(kind=rkind) :: x1, y1, z1
        real(kind=rkind) :: x2, y2, z2
        real(kind=rkind) :: x3, y3, z3
        real(kind=rkind) :: x4, y4, z4
    contains
        procedure :: volume => tetrahedron_xyz_volume
    end type tetrahedron_xyz

contains

    function tetrahedron_xyz_volume(self) result(v)
        class(tetrahedron_xyz), intent(in) :: self
        real(kind=rkind) :: v
        real(kind=rkind) :: dx2, dx3, dx4
        real(kind=rkind) :: dy2, dy3, dy4
        real(kind=rkind) :: dz2, dz3, dz4
        real(kind=rkind) :: det

        dx2 = self%x2 - self%x1
        dx3 = self%x3 - self%x1
        dx4 = self%x4 - self%x1

        dy2 = self%y2 - self%y1
        dy3 = self%y3 - self%y1
        dy4 = self%y4 - self%y1

        dz2 = self%z2 - self%z1
        dz3 = self%z3 - self%z1
        dz4 = self%z4 - self%z1

        det = dx2*(dy3*dz4 - dy4*dz3) - &
              dx3*(dy2*dz4 - dy4*dz2) + &
              dx4*(dy2*dz3 - dy3*dz2)

        v = abs(det) / 6.0_rkind
    end function tetrahedron_xyz_volume

end module solids3d
