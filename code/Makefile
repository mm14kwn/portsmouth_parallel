MF=	Makefile

#COMPILER
FC=	ftn
# On ARCHER, ftn is a wrapper for whichever Fortran compiler - GNU (gfortran), Intel (ifort), or Cray (crayftn) - has been chosen by loading the appropriate PrgEnv module prior to compilation.
CC=	cc
# Likewise, cc is a wrapper for whichever C compiler - GNU (gcc), Intel (icc), or Cray (craycc) has been loaded.

FFLAGS=	-g -DF_OPENMP_PRACTICAL
CFLAGS= $(FFLAGS)
LFLAGS=

EXE=	traffic_par

FSRC= \
	traffic_par.f90

CSRC=	utilities.c

#
# No need to edit below this line
#

.SUFFIXES:
.SUFFIXES: .f90 .c .o

OBJ=	$(FSRC:.f90=.o) $(CSRC:.c=.o)

.f90.o:
	$(FC) $(FFLAGS) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $<

all:	$(EXE)

$(EXE):	$(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ) $(LFLAGS)

$(OBJ):	$(MF)

tar:
	tar cvf $(EXE).tar $(MF) $(SRC) fuzzy.pgm submit.sh

clean:
	rm -f $(OBJ) $(EXE) core
