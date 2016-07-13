#!/bin/sh
export CROOT=/run/media/ling/CACHE/android_misc/
export ARCH=arm64
export CROSS_COMPILE=${CROOT}/UBERTC-aarch64-linux-android-4.9/bin/aarch64-linux-android-
export LD_PRELOAD=/usr/lib/libproxychains4.so
source ${CROOT}/venv/bin/activate

export KBUILD_OUTPUT=${CROOT}/${PWD##*/}_build
mkdir -p ${KBUILD_OUTPUT}
