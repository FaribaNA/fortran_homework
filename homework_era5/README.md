# ERA5 Daily Cumulative Correction

This program reads **hourly cumulative ERA5 precipitation and evaporation data** and converts them into **hourly incremental values** by removing cumulative accumulation and resetting at the start of each day.

---

##  Workflow

1. Read input file `rain-evap-era5.dat` containing ISO timestamps and cumulative values.  
2. Convert timestamps to datetime format and verify hourly time steps.  
3. Apply correction using the `correct_era5_daily_cum` subroutine.  
4. Write corrected hourly increments to `era5_corrected.txt`.

---

##  Files

```plaintext
.
├── types.f90
├── datetime.f90
├── dataanalyses.f90
├── main.f90
├── rain-evap-era5.dat
└── README.md
```

---

## ⚙️ Code Overview

| File | Description |
|------|--------------|
| **types.f90** | Defines numeric precision kinds (`ikind` for integers, `rkind` for reals). |
| **datetime.f90** | Provides tools to parse timestamps and calculate time differences. |
| **dataanalyses.f90** | Contains routines `diff1` and `correct_era5_daily_cum` for cumulative correction. |
| **main.f90** | Main program: reads input, applies correction, and writes the output file. |

---

##  Input Format

Input file: **`rain-evap-era5.dat`**

Each line should contain:
```plaintext
YYYY-MM-DDTHH:MM:SS  tp_cumulative  e_cumulative
```

- **DateTime:** ISO 8601 format (UTC)  
- **tp_cumulative:** Cumulative precipitation (mm)  
- **e_cumulative:** Cumulative evaporation (mm)

###  Example Input

```plaintext
2020-01-01T00:00:00  0.00  0.00
2020-01-01T01:00:00  0.10  0.00
2020-01-01T02:00:00  0.15  0.00
2020-01-01T03:00:00  0.20  0.00
2020-01-01T04:00:00  0.25  0.00
2020-01-01T05:00:00  0.25  0.00
2020-01-01T06:00:00  0.25  0.00
2020-01-01T07:00:00  0.30  0.00
2020-01-01T08:00:00  0.35  0.00
2020-01-01T09:00:00  0.35  0.00
2020-01-01T10:00:00  0.35  0.00
2020-01-01T11:00:00  0.35  0.00
2020-01-01T12:00:00  0.40  0.00
2020-01-01T13:00:00  0.45  0.00
2020-01-01T14:00:00  0.50  0.00
2020-01-01T15:00:00  0.55  0.00
2020-01-01T16:00:00  0.60  0.00
2020-01-01T17:00:00  0.65  0.00
2020-01-01T18:00:00  0.70  0.00
2020-01-01T19:00:00  0.70  0.00
2020-01-01T20:00:00  0.75  0.00
2020-01-01T21:00:00  0.75  0.00
2020-01-01T22:00:00  0.75  0.00
2020-01-01T23:00:00  0.75  0.00
2020-01-02T00:00:00  0.00  0.00
```

---

## Output Format

Output file: **`era5_corrected.txt`**

Each line contains:
```plaintext
index  tp_increment  e_increment
```

### Example Output (Partial)

```plaintext
       1        0.0000000000       0.0000000000
       2        0.1000000000       0.0000000000
       3        0.0500000000       0.0000000000
       4        0.0500000000       0.0000000000
       5        0.0500000000       0.0000000000
       6        0.0000000000       0.0000000000
       7        0.0000000000       0.0000000000
       8        0.0500000000       0.0000000000
       9        0.0500000000       0.0000000000
      10        0.0000000000       0.0000000000
      ...
      24        0.0000000000       0.0000000000
```

### Console Output Example

```plaintext
i    tp_cum         tp_inc          e_cum          e_inc
   1      0.000000       0.000000       0.000000       0.000000
   2      0.100000       0.100000       0.000000       0.000000
   ...
Wrote corrected hourly increments to era5_corrected.txt
```

---

## How to Build

You need a **Fortran compiler**, e.g. `gfortran`.

### Compile

```bash
 gfortran types.f90 dataanalyses.f90 datetime.f90 main.f90 -o result
```

### Run

```bash
./result
```
