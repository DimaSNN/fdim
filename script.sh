#/bin/bash
#defile variables

file=$1
if [ "x$1" = "x" ]; then
  echo You should add 'filename' as an argument
  exit
fi


cd
mkdir -p ~/fdim
cd fdim
rm -rf ~/fdim/tmp
cd tmp
##scp copy 'file' to here ./

#start doing
d2 $file -M 1,7 -V0 -o $file -t8
c2t $file.c2 -o $file.c2t
#здесь добавлен путь к директоррии с установленным матлабом
./run_calcFDim.sh /usr/local/MATLAB/R2015b/ $file
