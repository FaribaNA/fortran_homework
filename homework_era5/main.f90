program main
    use types
    use dataanalyses
    use datetime
    implicit none

    type :: era5data
        type(datetime_t) :: date
        real(kind=rkind) :: val
    end type era5data

    !Each element stores a datetime and a value.

    type(era5data), allocatable :: rain(:), evap(:)

    integer(kind=ikind) :: n, i, ierr
    integer(kind=ikind) :: fileid
    character(len=32)   :: ts
    real(kind=rkind)    :: val1, val2
    real(kind=rkind)    :: dt_sec
    real(kind=rkind), allocatable :: tp_cum(:), e_cum(:)
    real(kind=rkind), allocatable :: tp_inc(:), e_inc(:)

    open(newunit=fileid, file="rain-evap-era5.dat", &
        status="old", action="read", iostat=ierr)
    if (ierr /= 0_ikind) error stop "Cannot open input file (first pass)."

    ! number of lines
    n = 0_ikind
    do
        read(fileid, '(A)', iostat=ierr) ts
        if (ierr /= 0_ikind) exit
        n = n + 1_ikind
    end do
    close(fileid)

    if (n <= 0_ikind) error stop "No data in input file."

    allocate(rain(n), evap(n))
    allocate(tp_cum(n), e_cum(n), tp_inc(n), e_inc(n))

    open(newunit=fileid, file="rain-evap-era5.dat", &
        status="old", action="read", iostat=ierr)
    if (ierr /= 0_ikind) error stop "Cannot open input file (second pass)."

    do i = 1_ikind, n

        read(fileid, *, iostat=ierr) ts, val1, val2

        if (ierr /= 0_ikind .and. i > 1_ikind) then
            print *, "WARNING: read error at record ", i, " – copying previous VALUES from previous record."

            val1 = tp_cum(i-1)
            val2 = e_cum(i-1)

            ierr = 0_ikind
        end if

        if (ierr /= 0_ikind) error stop "Error reading data line."

        call parse_iso_datetime(trim(ts), rain(i)%date)
        evap(i)%date = rain(i)%date

        rain(i)%val = val1
        evap(i)%val = val2

        tp_cum(i) = val1
        e_cum(i)  = val2

        if (i > 1_ikind) then
            dt_sec = difftime(rain(i-1)%date, rain(i)%date, "sec")
            if (abs(dt_sec - 3600.0_rkind) > 1.0e-3_rkind) then
                print *, "WARNING: timestep not 3600 s at record ", i, " dt=", dt_sec
            end if
        end if
    end do
    close(fileid)

    call correct_era5_daily_cum(tp_cum, e_cum, tp_inc, e_inc)

    print *, "i    tp_cum         tp_inc          e_cum          e_inc"
    do i = 1_ikind, min(24_ikind, n)
        write(*,'(I4,4F14.6)') i, tp_cum(i), tp_inc(i), e_cum(i), e_inc(i)
    end do

    open(newunit=fileid, file="era5_corrected.txt", &
        status="replace", action="write", iostat=ierr)
    if (ierr /= 0_ikind) error stop "Cannot open output file."

    do i = 1_ikind, n
        write(fileid, '(I8,1X,2F20.10)') i, tp_inc(i), e_inc(i)
    end do

    close(fileid)

    deallocate(rain, evap, tp_cum, e_cum, tp_inc, e_inc)

    print *, "Wrote corrected hourly increments to era5_corrected.txt"

end program main
