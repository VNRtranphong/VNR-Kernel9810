#!/bin/bash
# kernel build script by geiti94 v0.1 (made for s10e/s10/s10/n10/n10+ sources)

# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

export VARIANT=eur	
export ARCH=arm64
export BUILD_CROSS_COMPILE=/home/tranphong/VNR-Kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export BUILD_JOB_NUMBER=128

	
VNR_NAME="V10.Kernel.VNR."	
VNR_VER="VietNamⓇ - V10"
VNR_SP="N960X.G965X.G960X"
VNR_ZIP="$VNR_NAME$VNR_SP"

RDIR=$(pwd)
OUTDIR=$RDIR/arch/arm64/boot
DTSDIR=$RDIR/arch/arm64/boot/dts/exynos
DTBDIR=$OUTDIR/dtb
DTCTOOL=$RDIR/tools/mkdtimage
INCDIR=$RDIR/include
MAINDIR=/home/tranphong/1.VNR-TEAM/VNR-Kernel/9810-Kernel

KERNEL_DEFCONFIGN9=exynos9810-crownlte_defconfig

KERNEL_DEFCONFIGS9P=exynos9810-star2lte_defconfig

KERNEL_DEFCONFIGS9=exynos9810-starlte_defconfig


	
function FUNC_CLEAN_DTB
{
	if ! [ -d $RDIR/arch/$ARCH/boot/dts ] ; then
		echo "no directory : "$RDIR/arch/$ARCH/boot/dts""
	else
		echo "rm files in : "$RDIR/arch/$ARCH/boot/dts/*.dtb""
		rm $RDIR/arch/$ARCH/boot/dts/*.dtb
		rm $RDIR/arch/$ARCH/boot/dtb/*.dtb
		rm $RDIR/arch/$ARCH/boot/boot.img-dtb
		rm $RDIR/arch/$ARCH/boot/boot.img-zImage
	fi
}

function FUNC_BUILD_KERNELN9
{
	echo ""
        echo "=============================================="
        echo "START : FUNC_BUILD_KERNEL"
        echo "=============================================="
        echo "N9 KERNEL"
        echo "build common config="$KERNEL_DEFCONFIGN9 ""

	make clean
	make mrproper
	export ANDROID_MAJOR_VERSION=q
	export LOCALVERSION=-$VNR_VER
	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIGN9 || exit -1

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_KERNEL"
	echo "================================="
	echo ""
}

function FUNC_BUILD_KERNELS9
{
	echo ""
        echo "=============================================="
        echo "START : FUNC_BUILD_KERNEL"
        echo "=============================================="
        echo "S9 KERNEL"
        echo "build common config="$KERNEL_DEFCONFIGS9 ""

	make clean
	make mrproper
	export ANDROID_MAJOR_VERSION=q
	export LOCALVERSION=-$VNR_VER
	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIGS9 || exit -1

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_KERNEL"
	echo "================================="
	echo ""
}

function FUNC_BUILD_KERNELS9P
{
	echo ""
        echo "=============================================="
        echo "START : FUNC_BUILD_KERNEL"
        echo "=============================================="
        echo "S9P KERNEL"
        echo "build common config="$KERNEL_DEFCONFIGS9P ""

	make clean
	make mrproper
	export ANDROID_MAJOR_VERSION=q
	export LOCALVERSION=-$VNR_VER
	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIGS9P || exit -1

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_KERNEL"
	echo "================================="
	echo ""
}

function FUNC_BUILD_RAMDISKN9
{
	mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
	mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dt

			rm -f $RDIR/ramdisk/N960/split_img/boot.img-zImage
			rm -f $RDIR/ramdisk/N960/split_img/boot.img-dt
			mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/N960/split_img/boot.img-zImage
			mv -f $RDIR/arch/$ARCH/boot/boot.img-dt $RDIR/ramdisk/N960/split_img/boot.img-dt
			
			cd $RDIR/ramdisk/N960
			./repackimg.sh --nosudo
			echo SEANDROIDENFORCE >> image-new.img

}

function FUNC_BUILD_RAMDISKS9P
{
	mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
	mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dt

			rm -f $RDIR/ramdisk/G965/split_img/boot.img-zImage
			rm -f $RDIR/ramdisk/G965/split_img/boot.img-dt
			mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/G965/split_img/boot.img-zImage
			mv -f $RDIR/arch/$ARCH/boot/boot.img-dt $RDIR/ramdisk/G965/split_img/boot.img-dt
			cd $RDIR/ramdisk/G965
			./repackimg.sh --nosudo
			echo SEANDROIDENFORCE >> image-new.img
}


function FUNC_BUILD_RAMDISKS9
{
	mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
	mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dt

			rm -f $RDIR/ramdisk/G960/split_img/boot.img-zImage
			rm -f $RDIR/ramdisk/G960/split_img/boot.img-dt
			mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/G960/split_img/boot.img-zImage
			mv -f $RDIR/arch/$ARCH/boot/boot.img-dt $RDIR/ramdisk/G960/split_img/boot.img-dt
			cd $RDIR/ramdisk/G960
			./repackimg.sh --nosudo
			echo SEANDROIDENFORCE >> image-new.img

}

function FUNC_BUILD_ZIPN9
{
			MODEL=crownlte
			cd $RDIR/ramdisk/build
			rm $MODEL-$VARIANT.img

			mv -f $RDIR/ramdisk/N960/image-new.img $RDIR/ramdisk/build/$MODEL-$VARIANT.img
			cd $MAINDIR
}


function FUNC_BUILD_ZIPS9P
{

			MODEL=star2lte
			cd $RDIR/ramdisk/build
			rm $MODEL-$VARIANT.img

			mv -f $RDIR/ramdisk/G965/image-new.img $RDIR/ramdisk/build/$MODEL-$VARIANT.img
			cd $MAINDIR
}

function FUNC_BUILD_ZIPS9
{

			MODEL=starlte
			cd $RDIR/ramdisk/build
			rm $MODEL-$VARIANT.img

			mv -f $RDIR/ramdisk/G960/image-new.img $RDIR/ramdisk/build/$MODEL-$VARIANT.img
			cd $MAINDIR
}

function make_zip
{
		cd $RDIR/ramdisk/build
		rm -f `$VNR_ZIP`.zip
		zip -r9 `echo $VNR_ZIP`.zip *
		cd $MAINDIR
}


# MAIN FUNCTION
rm -rf ./build.log
(
	START_TIME=`date +%s`

echo -e "${green}"
echo "tranphong Kernel Creation Script:"
echo

echo "---------------"
echo "Kernel Version:"
echo "---------------"

echo -e "${red}"; echo -e "${blink_red}"; echo "$VNR_VER"; echo -e "${restore}";

echo -e "${green}"
echo "-----------------"
echo "Making tranphong Kernel:"
echo "-----------------"

echo -e "${red}"; echo -e "${blink_red}"; echo "Start N9 kernel!"; echo -e "${restore}";	
echo ""
echo "-----------------"
	FUNC_BUILD_KERNELN9
	FUNC_BUILD_RAMDISKN9
	FUNC_BUILD_ZIPN9
echo "-----------------"
echo -e "${red}"; echo -e "${blink_red}"; echo "Start S9 Plus kernel!"; echo -e "${restore}";
echo "-----------------"
	
	FUNC_BUILD_KERNELS9P
	FUNC_BUILD_RAMDISKS9P
	FUNC_BUILD_ZIPS9P
echo "-----------------"
echo -e "${red}"; echo -e "${blink_red}"; echo "Start S9 kernel!"; echo -e "${restore}";
echo "-----------------"
	
	FUNC_BUILD_KERNELS9
	FUNC_BUILD_RAMDISKS9
	FUNC_BUILD_ZIPS9
	
while read -p "Do you want to zip kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done
	END_TIME=`date +%s`
	
	let "ELAPSED_TIME=$END_TIME-$START_TIME"
	echo "Total compile time was $ELAPSED_TIME seconds"

) 2>&1	| tee -a ./build.log
