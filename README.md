# Numerical Overflow & Loss of Significance

This project contains two simple Fortran programs that demonstrate important numerical concepts:
- **Integer overflow** during factorial computation.
- **Loss of significance** in floating-point arithmetic.

---

## Files

| File | Description |
|------|--------------|
| `00_overflow.f90` | Calculates factorial values using 32-bit and 64-bit integers to show where overflow occurs and how results drift. |
| `01_precision.f90` | shows when adding a very small number to 1.0 no longer changes the result, showing floating-point precision limits. |

---

## Requirements

A fortran compiler installed, such as **gfortran**.

Check if it’s installed:

```bash (tested in linux ubuntu version 24.05 LTS)
gfortran --version
If it’s not installed:

```bash
sudo apt update
sudo apt install gfortran

## Compilation

```bash
gfortran 00_overflow.f90 -o overflow
gfortran 01_precision.f90 -o precision
## Running the Programs
To run the factorial overflow program:

```bash
./overflow

## To run the loss of significance program:

```bash
./precision