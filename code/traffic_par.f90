PROGRAM TRAFFIC
IMPLICIT NONE

INTEGER, PARAMETER :: real_8_30 = SELECTED_REAL_KIND(P=8, R=30)
INTEGER :: N, TIMESTEPS, T, I
REAL(KIND=real_8_30) :: TOL, A
REAL(KIND=real_8_30), DIMENSION(:), ALLOCATABLE :: DUMMYVECTOR
REAL(KIND=real_8_30), DIMENSION(:,:), ALLOCATABLE :: GRID

!PRINT*, 'INPUT NUMBER OF TIMESTEPS'
!READ*, TIMESTEPS
TIMESTEPS=1000
!PRINT*, 'INPUT NUMBER OF GRIDS'
!READ*, N
N=1000
!PRINT*, 'INPUT CHECK TOLERANCE'
!READ*, TOL
TOL=0.00001
ALLOCATE(DUMMYVECTOR(N))
ALLOCATE(GRID(N,TIMESTEPS))
!$OMP PARALLEL DO
DO I=1,N
!CALL INIT_RANDOM_SEED()
CALL RANDOM_NUMBER(A)
GRID(I,1)=NINT(A)
END DO
!$OMP END PARALLEL DO
DO T=1,TIMESTEPS-1
   DUMMYVECTOR=0
   !$OMP PARALLEL DO
   DO I=1,N-1
      IF (ABS(1-GRID(I,T))<=TOL) THEN
         IF (ABS(GRID(I+1,T))<=TOL) THEN
            DUMMYVECTOR(I)=0
            DUMMYVECTOR(I+1)=1
         ELSE
            DUMMYVECTOR(I)=1
         END IF
      END IF
   END DO
   !$OMP END PARALLEL DO
   !$OMP PARALLEL DO
   DO I=1,N
      GRID(I,T+1)=DUMMYVECTOR(I)
   END DO
   !$OMP END PARALLEL DO
END DO

PRINT*, 'Run Complete - Writing to file'
OPEN(1, file='./cars_par.txt',status='new')
DO T=1,TIMESTEPS
   DO I=1,N
      WRITE(1,*) GRID(I,T)
   END DO
END DO
END PROGRAM TRAFFIC
