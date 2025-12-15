program main
    use types
    use vector2d_mod
    use shapes2d
    use solids3d
    implicit none

    type(vector2d) :: v1, v2, v3

    type(right_triangle)  :: rt
    type(rectangle)       :: rec
    type(triangle_xy)     :: tri
    type(quadrangle_xy)   :: quad
    type(tetrahedron_xyz) :: tet

    class(shape), allocatable :: s
    class(solid), allocatable :: s3d

    v1%x = 1.0_rkind; v1%y = 2.0_rkind
    v2%x = 3.0_rkind; v2%y = 4.0_rkind

    v3 = v1%sum(v2)

    print *, "vector2d sum:", v3%x, v3%y
    print *, "vector2d norm(v3):", v3%norm()

    rt%a = 3.0_rkind; rt%b = 4.0_rkind
    rec%width = 2.0_rkind; rec%height = 5.0_rkind

    if (allocated(s)) deallocate(s)
    allocate(s, source=rt)
    print *, "Right triangle: area =", s%area(), " perimeter =", s%perimeter()

    if (allocated(s)) deallocate(s)
    allocate(s, source=rec)
    print *, "Rectangle:      area =", s%area(), " perimeter =", s%perimeter()

    tri%x1 = 0.0_rkind; tri%y1 = 0.0_rkind
    tri%x2 = 3.0_rkind; tri%y2 = 0.0_rkind
    tri%x3 = 0.0_rkind; tri%y3 = 4.0_rkind

    if (allocated(s)) deallocate(s)
    allocate(s, source=tri)
    print *, "Triangle_xy:   area =", s%area(), " perimeter =", s%perimeter()

    quad%x1 = 0.0_rkind; quad%y1 = 0.0_rkind
    quad%x2 = 2.0_rkind; quad%y2 = 0.0_rkind
    quad%x3 = 2.0_rkind; quad%y3 = 5.0_rkind
    quad%x4 = 0.0_rkind; quad%y4 = 5.0_rkind

    if (allocated(s)) deallocate(s)
    allocate(s, source=quad)
    print *, "Quadrangle_xy: area =", s%area(), " perimeter =", s%perimeter()

    tet%x1 = 0.0_rkind; tet%y1 = 0.0_rkind; tet%z1 = 0.0_rkind
    tet%x2 = 3.0_rkind; tet%y2 = 0.0_rkind; tet%z2 = 0.0_rkind
    tet%x3 = 0.0_rkind; tet%y3 = 4.0_rkind; tet%z3 = 0.0_rkind
    tet%x4 = 0.0_rkind; tet%y4 = 0.0_rkind; tet%z4 = 5.0_rkind

    if (allocated(s3d)) deallocate(s3d)
    allocate(s3d, source=tet)
    print *, "Tetrahedron volume =", s3d%volume()

end program main
