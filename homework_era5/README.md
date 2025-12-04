
# ERA5 Daily Cumulative Correction

This program reads **hourly cumulative ERA5 precipitation and evaporation data** and corrects them into **hourly incremental values** by removing cumulative accumulation and resetting at the start of each day.  

The workflow:
1. Read input file `rain-evap-era5.dat` containing ISO timestamps and cumulative values.  
2. Convert timestamps to datetime format and check hourly time steps.  
3. Apply correction using the `correct_era5_daily_cum` subroutine.  
4. Write corrected hourly increments to `era5_corrected.txt`.

---

## Files

\`\`\`
.
├── types.f90
├── datetime.f90
├── dataanalyses.f90
├── main.f90
├── rain-evap-era5.dat
└── README.md
\`\`\`

---

## Code Overview

| File | Description |
|------|-------------|
| **types.f90** | Defines numeric precision kinds (`ikind` for integers, `rkind` for reals). |
| **datetime.f90** | Provides tools to parse timestamps and calculate time differences. |
| **dataanalyses.f90** | Contains the routines `diff1` and `correct_era5_daily_cum` for cumulative correction. |
| **main.f90** | Main program: reads input, calls correction routines, and writes output. |

---

## Input Format

Input file: **\`rain-evap-era5.dat\`**

Each line should contain:
\`\`\`
YYYY-MM-DDTHH:MM:SS  tp_cumulative  e_cumulative
\`\`\`

- **DateTime:** ISO 8601 format (UTC)  
- **tp_cumulative:** Cumulative precipitation (e.g., mm)  
- **e_cumulative:** Cumulative evaporation (e.g., mm)  

### Input format

\`\`\`
2020-01-01T00:00:00  0.00  0.00
2020-01-01T01:00:00  0.10  0.00
...
2020-01-01T22:00:00  0.75  0.00
2020-01-01T23:00:00  0.75  0.00
2020-01-02T00:00:00  0.00  0.00
\`\`\`

---

## Output format

Output file: **\`era5_corrected.txt\`**

Each line contains:
\`\`\`
index  tp_increment  e_increment
\`\`\`

Example (partial) output:

\`\`\`
       1        0.0000000000       0.0000000000
       2        0.1000000000       0.0000000000
       3        0.0500000000       0.0000000000
      ...
      ...
      24        0.0000000000       0.0000000000
\`\`\`

The program also prints a short summary to the screen:
\`\`\`
i    tp_cum         tp_inc          e_cum          e_inc
   1      0.000000       0.000000       0.000000       0.000000
   2      0.100000       0.100000       0.000000       0.000000
   ...
Wrote corrected hourly increments to era5_corrected.txt
\`\`\`

---

## How to Build

You need a **Fortran compiler**, e.g. \`gfortran\`.

### Compile

```bash
gfortran types.f90 dataanalyses.f90 datetime.f90 main.f90 -o result
```

### Run

```bash
./result
```
