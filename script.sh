#/bin/bash
#defile variables
TISEAN=~/Tisean_3.0.0/bin
WORK=~/fdim

file=$1
if [ "x$1" = "x" ]; then
  echo You should add 'filename' as an argument
  exit
fi


cd
mkdir -p $WORK 
cd fdim
rm -rf $WORK/tmp
rm -rf $WORK/dimension.dat
cd tmp
##scp copy 'file' to here ./

#start processing by Tisean 
$TISEAN/d2 $file -M 1,7 -V0 -o $file -t8
$TISEAN/c2t $file.c2 -o $file.c2t
#здесь добавлен путь к директоррии с установленным матлабом
./run_calcFDim.sh /usr/local/MATLAB/R2015b/ $file.c2t
