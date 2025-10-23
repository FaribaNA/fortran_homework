# Fortran Homework Repository

This repository contains two Fortran homework projects focused on numerical computation and modular programming.  
Each project demonstrates key programming concepts and numerical principles with clear, well-structured examples.

---

## Homework 1:

This homework explores two essential numerical issues in Fortran:

1. Integer overflow during factorial computation.  
2. Loss of significance in floating-point arithmetic.

### Files
| File | Description |
|------|--------------|
| `00_overflow.f90` | Demonstrates overflow when calculating factorials with 32-bit and 64-bit integers. |
| `01_precision.f90` | Demonstrates floating-point precision limits when adding very small values to 1.0. |

### How to Run
```bash
gfortran 00_overflow.f90 -o overflow
./overflow

gfortran 01_precision.f90 -o precision
./precision

## Homework 2: 
This homework practices modular programming in Fortran by defining and using simple mathematical and geometrical functions.  
The program demonstrates how to organize code into modules, pass arguments with `intent`, and perform basic calculations.

### Files

| File | Description |
|------|--------------|
| `types.f90` | Defines kind parameters for integer (`ikind`) and real (`rkind`) precision. |
| `mathfun.f90` | Contains `add()` and `swap()` routines for basic arithmetic operations. |
| `geom2d.f90` | Provides `carea()`, `sarea()`, and `rectap()` functions for geometric calculations. |
| `main.f90` | Main program that prompts the user, performs calculations, and prints results. |

---

### How to Run

Make sure all source files are in the same directory.  
Then compile and execute using the following commands:

```bash
gfortran types.f90 mathfun.f90 geom2d.f90 main.f90 -o testrun
./testrun
