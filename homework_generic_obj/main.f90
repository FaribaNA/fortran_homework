program main
    use types
    use vector2d_mod
    use shapes2d
    use solids3d
    implicit none

    type(vector2d) :: v

    type(right_triangle) :: rt
    type(rectangle) :: rec
    type(triangle_xy) :: tri
    type(quadrangle_xy) :: quad

    type(tetrahedron_xyz) :: tet
    type(cylinder) :: cyl

    v%x = 3.0_rkind
    v%y = 4.0_rkind

    rt%a = 3.0_rkind
    rt%b = 4.0_rkind

    rec%width  = 2.0_rkind
    rec%height = 5.0_rkind

    tri%x1 = 0.0_rkind; tri%y1 = 0.0_rkind
    tri%x2 = 3.0_rkind; tri%y2 = 0.0_rkind
    tri%x3 = 0.0_rkind; tri%y3 = 4.0_rkind

    quad%x1 = 0.0_rkind; quad%y1 = 0.0_rkind
    quad%x2 = 2.0_rkind; quad%y2 = 0.0_rkind
    quad%x3 = 2.0_rkind; quad%y3 = 5.0_rkind
    quad%x4 = 0.0_rkind; quad%y4 = 5.0_rkind

    tet%x1 = 0.0_rkind; tet%y1 = 0.0_rkind; tet%z1 = 0.0_rkind
    tet%x2 = 3.0_rkind; tet%y2 = 0.0_rkind; tet%z2 = 0.0_rkind
    tet%x3 = 0.0_rkind; tet%y3 = 4.0_rkind; tet%z3 = 0.0_rkind
    tet%x4 = 0.0_rkind; tet%y4 = 0.0_rkind; tet%z4 = 5.0_rkind

    cyl%radius = 2.0_rkind
    cyl%height = 6.0_rkind

    print *, "right_triangle = ", area(rt)
    print *, "rectangle = ", area(rec)
    print *, "triangle_xy = ", area(tri)
    print *, "quadrangle_xy = ", area(quad)
    print *, "tetrahedron = ", area(tet)
    print *, "cylinder = ", area(cyl)
    print *, "vector norm = ", norm(v)

end program main
