#!/bin/bash

# Minimization
#
mpirun -np 4 sander.MPI -O \
 -p testout/NLN_All.parm7 \
 -c testout/NLN_All.rst7 \
 -i testin/min.in \
 -o testout/min.o \
 -r testout/min.rst7 \
 -inf testout/min.info 

