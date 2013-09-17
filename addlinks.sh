#!/bin/sh

prefix=`brew --prefix`

destdir=$prefix/opt/msp430-gcc/msp430
mkdir -p $destdir
cd $destdir

# Link the files from each of the other installed formula (besides gcc itself).
for component in binutils libc mcu ; do
    srcdir=$prefix/opt/msp430-$component/msp430
    for fn in `find $srcdir` ; do
        if [ ! -d $fn ] ; then
            echo $fn
            relpath=`echo $fn | sed s:""$srcdir/""::`
            mkdir -p `dirname $relpath`
            ln -s $fn $relpath
        fi
    done
done
