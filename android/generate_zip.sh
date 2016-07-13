#!/bin/sh
CURDIR=$(cd `dirname $0`;pwd)
KERNLBUILD=/run/media/ling/CACHE/android_misc/android_kernel_sony_msm_build
KERNLIMAGE=${KERNLBUILD}/arch/arm/boot/zImage-dtb
MKBOOTIMG=/run/media/ling/CACHE/android_misc/android_kernel_sony_msm_zip/mkbootimg_tools
CROSS=/run/media/ling/CACHE/android_misc/hyper-toolchains-arm-eabi-5.x/bin/arm-eabi-
STRIP=${CROSS}strip
BOOTIMG=boot
ZIPPREFIX=Kernel_Amami_AOSP_6
cd ${CURDIR}

[ -f ${KERNLIMAGE} ] || exit 1
[ -d ${MKBOOTIMG}/${BOOTIMG} ] || exit 1

rm -f *.zip
#rm -f  zip/boot.img
rm -f  zip/kernel
rm -f  zip/lib/modules/*.ko
#rm -f  mkbootimg_tools/boot.img
#rm -f  mkbootimg_tools/boot/kernel

cp ${KERNLIMAGE} mkbootimg_tools/boot/kernel
find ${KERNLBUILD} -iregex "\S+\.ko$" -exec cp {} zip/lib/modules/ \;
${STRIP} --strip-unneeded zip/lib/modules/*.ko

#cp ${KERNLIMAGE} mkbootimg_tools/boot/kernel
#cd ${CURDIR}/mkbootimg_tools
#./mkboot boot boot.img
#cp boot.img ${CURDIR}/zip/boot.img
cp ${KERNLIMAGE} ${CURDIR}/zip/kernel

cd ${CURDIR}/zip
DATE=$(date +"%Y%m%d")
zip -r ../${ZIPPREFIX}_${DATE}_unsigned.zip ./*
cd ${CURDIR}
mysign ${DATE}_unsigned.zip ${DATE}.zip || exit 1
md5sum ${DATE}.zip > ${DATE}.zip.md5
rm -f ${DATE}_unsigned.zip
