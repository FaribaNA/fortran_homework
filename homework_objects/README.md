# 2D/3D Geometry with OOP in Fortran

This program demonstrates **object-oriented programming (OOP)** using:
- a simple **2D vector** type with basic operations, and  
- abstract base types for **2D shapes** and **3D solids**, with concrete implementations (area/perimeter/volume).

---

## Workflow

1. Define numeric precision (`rkind`) in `types.f90`.  
2. Implement a 2D vector type (`vector2d`) with `sum()` and `norm()`.  
3. Define an abstract `shape` type with deferred `area()` and `perimeter()` methods, then implement:
   - `right_triangle`
   - `rectangle`
   - `triangle_xy`
   - `quadrangle_xy`
4. Define an abstract `solid` type with deferred `volume()` method, then implement:
   - `tetrahedron_xyz`
5. Run `main.f90` to create objects, call polymorphic methods, and print results.

---

## Files

```plaintext
.
├── types.f90
├── vector2d_mod.f90
├── shapes2d.f90
├── solids3d.f90
├── main.f90
└── README.md
```

---

## Code Overview

| File | Description |
|------|-------------|
| **types.f90** | Defines numeric precision kind `rkind` (double precision). |
| **vector2d_mod.f90** | Defines type `vector2d` with methods `sum()` and `norm()`. |
| **shapes2d.f90** | Defines abstract type `shape` (deferred `area()`, `perimeter()`), and concrete 2D shapes. |
| **solids3d.f90** | Defines abstract type `solid` (deferred `volume()`), and concrete 3D solid `tetrahedron_xyz`. |
| **main.f90** | Main driver program demonstrating polymorphism and geometry calculations. |

---

## Input Format

This program uses **no external input files**.  
All values are defined directly inside `main.f90`.

---

## Output Format

Results are printed to the console:
- vector sum and norm,
- area and perimeter for 2D shapes,
- volume for the 3D tetrahedron.

---

## How to Build

You need a **Fortran compiler**, e.g. `gfortran`.

### Compile

```bash
gfortran types.f90 vector2d_mod.f90 shapes2d.f90 solids3d.f90 main.f90 -o result
```

### Run

```bash
./result
```
