program loss_of_significance
  implicit none

!Define the main variables:
  real(8) :: big, small, sum, delta   ! big = base value, small = added number, delta = sum - big
  integer :: step

!set initial values:
  big = 1.0d0
  small = 1.0d0
  step = 0

!Show titles of the results:
  print *, ' step          small               big                sum                  delta'
  print *, ' ----------------------------------------------------------------------------- '

!Divide "small" by 2 until it stops changing "big":
  do
     sum = big + small
     delta = sum - big
     print '(I5,4ES20.12)', step, small, big, sum, delta      

     if (sum <= big) exit                                     

     small = small / 2.0d0                                   
     step = step + 1
  end do

!Final summary results
  print *, '----------------------------------------------------------------------------------------'
  print '(A,I5,A,ES20.12)', 'At step', step, ', the added value no longer changed the result: ', small
  print '(A,I5,A,ES20.12)', 'At step', step-1, ', machine epsilon was: ', small*2.0d0

end program loss_of_significance

