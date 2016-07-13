#!/bin/sh
export CROOT=/run/media/ling/CACHE/android_misc/
export ARCH=arm
#export CROSS_COMPILE=${CROOT}/UBERTC-arm-eabi-4.9/bin/arm-eabi-
export CROSS_COMPILE=${CROOT}/hyper-toolchains-arm-eabi-5.x/bin/arm-eabi-
export LD_PRELOAD=/usr/lib/libproxychains4.so
export LANG=C
source ${CROOT}/venv/bin/activate

export KBUILD_OUTPUT=${CROOT}/${PWD##*/}_build
mkdir -p ${KBUILD_OUTPUT}
