#!/bin/bash



export ANDROID_MAJOR_VERSION=q
export ARCH=arm64
make exynos9810-crownlte_defconfig
make -j16
