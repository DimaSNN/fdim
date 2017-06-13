#/bin/bash

file=$1

#start doing
d2 $file -M 1,7 -V0 -o $file -t12
c2t $file.c2 -o $file.c2t
