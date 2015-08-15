#!/bin/sh
export KERNELDIR=`readlink -f .`
export CROSS_COMPILE=/home/nian/arm-eabi-4.8/bin/arm-eabi-
export ARCH=arm

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_sc03e_new_defconfig
fi

. $KERNELDIR/.config

mv .git .git-halt

cd $KERNELDIR/
make -j8 

mkdir -p $KERNELDIR/BUILT_I9305_smdk4x12/lib/modules

rm $KERNELDIR/BUILT_I9305_smdk4x12/lib/modules/*
rm $KERNELDIR/BUILT_I9305_smdk4x12/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_I9305_smdk4x12/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_I9305_smdk4x12/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_I9305_smdk4x12/

mv .git-halt .git
