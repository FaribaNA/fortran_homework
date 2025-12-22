module solids3d

    use types
    implicit none
    private
    public :: tetrahedron_xyz, cylinder, area


    type :: tetrahedron_xyz
        real(kind=rkind) :: x1, y1, z1
        real(kind=rkind) :: x2, y2, z2
        real(kind=rkind) :: x3, y3, z3
        real(kind=rkind) :: x4, y4, z4
    end type tetrahedron_xyz


    type :: cylinder
        real(kind=rkind) :: radius
        real(kind=rkind) :: height
    end type cylinder


    interface area
        module procedure area_tetrahedron
        module procedure area_cylinder
    end interface area


contains


    function area_tetrahedron(t) result(a)
        type(tetrahedron_xyz), intent(in) :: t
        real(kind=rkind) :: a
        real(kind=rkind) :: ax, ay, az
        real(kind=rkind) :: bx, by, bz
        real(kind=rkind) :: nx, ny, nz

        a = 0.0_rkind

        ! Face (1,2,3)
        ax = t%x2 - t%x1; ay = t%y2 - t%y1; az = t%z2 - t%z1
        bx = t%x3 - t%x1; by = t%y3 - t%y1; bz = t%z3 - t%z1
        nx = ay*bz - az*by
        ny = az*bx - ax*bz
        nz = ax*by - ay*bx
        a = a + 0.5_rkind * sqrt(nx*nx + ny*ny + nz*nz)

        ! Face (1,2,4)
        ax = t%x2 - t%x1; ay = t%y2 - t%y1; az = t%z2 - t%z1
        bx = t%x4 - t%x1; by = t%y4 - t%y1; bz = t%z4 - t%z1
        nx = ay*bz - az*by
        ny = az*bx - ax*bz
        nz = ax*by - ay*bx
        a = a + 0.5_rkind * sqrt(nx*nx + ny*ny + nz*nz)

        ! Face (1,3,4)
        ax = t%x3 - t%x1; ay = t%y3 - t%y1; az = t%z3 - t%z1
        bx = t%x4 - t%x1; by = t%y4 - t%y1; bz = t%z4 - t%z1
        nx = ay*bz - az*by
        ny = az*bx - ax*bz
        nz = ax*by - ay*bx
        a = a + 0.5_rkind * sqrt(nx*nx + ny*ny + nz*nz)

        ! Face (2,3,4)
        ax = t%x3 - t%x2; ay = t%y3 - t%y2; az = t%z3 - t%z2
        bx = t%x4 - t%x2; by = t%y4 - t%y2; bz = t%z4 - t%z2
        nx = ay*bz - az*by
        ny = az*bx - ax*bz
        nz = ax*by - ay*bx
        a = a + 0.5_rkind * sqrt(nx*nx + ny*ny + nz*nz)
    end function area_tetrahedron


    function area_cylinder(c) result(a)
        type(cylinder), intent(in) :: c
        real(kind=rkind) :: a
        a = 2.0_rkind * 3.141592653589793_rkind * c%radius * (c%height + c%radius)
    end function area_cylinder


end module solids3d
