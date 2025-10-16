program overflow
  implicit none

!Define the main variables:
  integer(kind=4) :: fact4, prev_fact4, check4     !int32 current factorial, previous factorial, and check value (fact4/n)
  integer(kind=8) :: fact8, prev_fact8, check8     !int64 current factorial, previous factorial, and check value (fact8/n)
  integer(kind=8) :: true_val_64, delta64          !expected factorial in 64-bit and its difference from int32
  integer :: n                                     !loop counter

!Set initial values
  fact4 = 1; prev_fact4 = 1
  fact8 = 1_8; prev_fact8 = 1_8

!Print the titles of the results(int32):
  print *
  print *, 'Calculating factorial(int32):'
  print *, '  n           (n-1)!                       n!                 (n!/n)                    delta'
  print *, ' ---------------------------------------------------------------------------------------'

!first row
  print '(I5,1X,I18,3X,I20,2X,I18,3X,I22)', 1, prev_fact4, fact4, fact4, 0_8

!Loop over n for int32 to detect overflow:
  do n = 2, 1000000
     prev_fact4 = fact4
     true_val_64 = int(prev_fact4, kind=8) * int(n, kind=8)
     fact4 = fact4 * n
     check4 = fact4 / n
     delta64 = int(fact4, kind=8)- true_val_64

     print '(I5,1X,I18,3X,I20,2X,I18,3X,I22)', n, prev_fact4, fact4, check4, delta64

     if (fact4 <= 0 .or. fact4 < prev_fact4) then
        print *
        print *, "int32 overflow detected at n =", n
        print *, "Previous factorial =", prev_fact4
        print *, "Current factorial =", fact4, "   <- value decreased -> overflow"
        exit
     end if
  end do

!Print the titles of the results(int64):
  print *
  print *, 'Calculating factorial (int64):'
  print *, '   n             (n-1)!                     n!                      (n!/n)'
  print *, ' ------------------------------------------------------------------------'

!first row:
  print '(I6,2X,I20,2X,I20,2X,I20)', 1, prev_fact8, fact8, fact8

!Loop over n for int64 to detect overflow:
  do n = 2, 1000000
     prev_fact8 = fact8
     fact8 = fact8 * int(n,8)
     check8 = fact8 / int(n,8)
     print '(I6,2X,I20,2X,I20,2X,I20)', n, prev_fact8, fact8, check8

     if (fact8 <= 0_8 .or. fact8 < prev_fact8) then
        print *
        print *, "int64 overflow detected at n =", n
        print *, "Previous factorial =", prev_fact8
        print *, "Current factorial =", fact8, "   <- value decreased -> overflow"
        exit
     end if
  end do

end program overflow
