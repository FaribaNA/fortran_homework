FC      = gfortran
# Development/Debug Flags (Full safety)
FFLAGS  = -Wall -Wextra -g -fbounds-check -fimplicit-none

# List all module object files
ALL_objs= types.o sort_numbers.o

# Default target: builds the executable
all: main.o $(ALL_objs)
	$(FC) -g -o Fariba main.o $(ALL_objs)

# --- Module Dependency Rules ---

# types.o: Only depends on its source file
types.o: types.f90
	$(FC) $(FFLAGS) -c types.f90

# sort_numbers.o: Depends on types.o because it 'USES types'
sort_numbers.o: types.o sort_numbers.f90
	$(FC) $(FFLAGS) -c sort_numbers.f90

# main.o: Depends on ALL_objs because it 'USES sort_numbers'
main.o: $(ALL_objs) main.f90
	$(FC) $(FFLAGS) -c main.f90

# Clean rule: removes all intermediate files (.o and .mod files)
clean:
	rm -f *.o *.mod Fariba
