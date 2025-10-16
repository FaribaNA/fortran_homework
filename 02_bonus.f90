program combined_experiments
  implicit none

  integer(kind=4) :: fact4, prev_fact4
  integer(kind=8) :: fact8, prev_fact8
  integer :: n, overflow32, overflow64
  real(8) :: big, small, sum
  integer :: step

  fact4 = 1; prev_fact4 = 1
  fact8 = 1_8; prev_fact8 = 1_8
  overflow32 = 0; overflow64 = 0

  print *
  print *, '--- Integer Factorial Overflow ---'

  do n = 2, 1000000
     prev_fact4 = fact4
     fact4 = fact4 * n
     if (fact4 <= 0 .or. fact4 < prev_fact4) then
        overflow32 = n
        exit
     end if
  end do

  do n = 2, 1000000
     prev_fact8 = fact8
     fact8 = fact8 * int(n,8)
     if (fact8 <= 0_8 .or. fact8 < prev_fact8) then
        overflow64 = n
        exit
     end if
  end do

  print *
  print *, 'int32 overflow detected at n =', overflow32
  print *, 'Number of safe iterations (int32):', overflow32 - 1
  print *, 'Overflow occurs at ', overflow32, '! = ', real(prev_fact4,8)*overflow32, &
           ', exceeding the 31-bit limit (~2.14×10^9);'
  print *, 'the stored value wraps to ', fact4, ' due to bit truncation.'
  print *
  print *, '------------------------------------------------------------'
  print *, 'NOTE: The int32 overflow is reported one step late because of the condition used:'
  print *, '    if (fact4 <= 0 .or. fact4 < prev_fact4) then'
  print *, 'This condition detects overflow only *after* it occurs, so the last correct value'
  print *, 'is (n-1)! = 12! = 479001600, while overflow is detected at n = 14.'
  print *, '------------------------------------------------------------'
  print *
  print *, 'int64 overflow detected at n =', overflow64

  print *, 'Number of safe iterations (int64):', overflow64 - 1
  print *, 'Overflow occurs at ', overflow64, '! = ', real(prev_fact8,8)*overflow64, &
           ', exceeding the 63-bit limit (~9.22×10^18);'
  print *, 'the stored value wraps to ', fact8, ' due to bit truncation.'
  print *
  print *, '--- Real(8) Precision Loss ---'
  print *

  big = 1.0d0
  small = 1.0d0
  step = 0

  do
     sum = big + small
     if (sum <= big) exit
     small = small / 2.0d0
     step = step + 1
  end do

  print *, 'Note: This test halves "small" until 1.0 + small = 1.0.'
  print *, 'The last value that changed (small*2) is the machine epsilon (~2^-52 ≈ 2.22E-16).'
  print *, 'Double precision (real(8)) gives about 15–16 decimal digits of accuracy.'
  print *
  print *, 'Precision loss after step:', step-1
  print *, 'Machine epsilon ≈', small * 2.0d0
  print *
  print *, 'At step', step, ', 1.0 +', small, 'no longer changes 1.0.'

end program combined_experiments

