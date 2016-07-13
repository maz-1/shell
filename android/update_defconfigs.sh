#!/bin/bash
export CROOT=$(cd `dirname $0`;pwd)
export ARCH=arm
export CROSS_COMPILE=${CROOT}/hyper-toolchains-arm-eabi-5.x/bin/arm-eabi-

export KBUILD_OUTPUT=${CROOT}/${PWD##*/}_configs
mkdir -p ${KBUILD_OUTPUT}

DEVICES=(rhine_amami rhine_honami rhine_togari shinano_aries shinano_castor shinano_leo shinano_scorpion shinano_sirius yukon_eagle yukon_flamingo yukon_seagull yukon_tianchi)

for device in ${DEVICES[@]}
do
  defconfig=aosp_${device}_defconfig
  rm -f ${KBUILD_OUTPUT}/.config
  if test -f ${KBUILD_OUTPUT}/${defconfig}.config ; then
    cp -f ${KBUILD_OUTPUT}/${defconfig}.config ${KBUILD_OUTPUT}/.config ;
    make silentoldconfig ;
    make savedefconfig ;
    mv -f ${KBUILD_OUTPUT}/defconfig ${CROOT}/${PWD##*/}/arch/arm/configs/${defconfig} 
  else
    make ${defconfig} ; mv ${KBUILD_OUTPUT}/.config ${KBUILD_OUTPUT}/${defconfig}.config
  fi
done

cp -f ${KBUILD_OUTPUT}/aosp_rhine_amami_defconfig.config ${CROOT}/${PWD##*/}_build/.config
