#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/AGNi_stamp_CM.sh
. ~/gcc_prebuilt_4.8.sh

export ARCH=arm

if [ ! -f $KERNELDIR/.config ];
then
   make defconfig psn_n7105_new_R4P0_defconfig
fi

. $KERNELDIR/.config

mv .git .git-halt

cd $KERNELDIR/
make -j3 || exit 1

mkdir -p $KERNELDIR/BUILT_N7105_R4P0_smdk4x12/lib/modules

rm $KERNELDIR/BUILT_N7105_R4P0_smdk4x12/lib/modules/*
rm $KERNELDIR/BUILT_N7105_R4P0_smdk4x12/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_N7105_R4P0_smdk4x12/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_N7105_R4P0_smdk4x12/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_N7105_R4P0_smdk4x12/

mv .git-halt .git

