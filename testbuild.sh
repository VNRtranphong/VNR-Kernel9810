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

	
VNR_NAME="R1.Kernel.VNR."	
VNR_VER="VietNamⓇ.ONEUI 3.0 - R1"
VNR_SP="N960X.G965X.G960X"
VNR_ZIP="$VNR_NAME$VNR_SP"
VNR_Z=".zip"
VNR_PLATFORM=10.0.0


RDIR=$(pwd)
OUTDIR=$RDIR/arch/arm64/boot
DTSDIR=$RDIR/arch/arm64/boot/dts/exynos
DTBDIR=$OUTDIR/dtb
DTCTOOL=$RDIR/tools/mkdtimage
INCDIR=$RDIR/include

MAINDIR=/home/tranphong/1.VNR-TEAM/VNR-Kernel/VNR-Kernel9810

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
	make clean
	make mrproper
}

function FUNC_BUILD_KERNELN9
{
	echo ""
        echo "=============================================="
        echo "START : FUNC_BUILD_KERNEL"
        echo "=============================================="
        echo "N9 KERNEL"
        echo "build common config="$KERNEL_DEFCONFIGN9 ""
	export PLATFORM_VERSION=10.0.0
	export ANDROID_MAJOR_VERSION=q
	export LOCALVERSION=-$VNR_VER
	MODEL=crownlte

	echo -e "${red}"; echo -e "${blink_red}"; echo "Make IMAGE"; echo -e "${restore}";
	
	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIGN9 || exit -1

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	echo -e "${red}"; echo -e "${blink_red}"; echo "Make RAMDISK"; echo -e "${restore}";


	mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
	mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dt

			rm -f $RDIR/ramdisk/30UIN9/split_img/boot.img-zImage
			rm -f $RDIR/ramdisk/30UIN9/split_img/boot.img-dt
			mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/30UIN9/split_img/boot.img-zImage
			mv -f $RDIR/arch/$ARCH/boot/boot.img-dt $RDIR/ramdisk/30UIN9/split_img/boot.img-dt
			
			cd $RDIR/ramdisk/30UIN9
			./repackimg.sh --nosudo
			echo SEANDROIDENFORCE >> image-new.img


	echo -e "${red}"; echo -e "${blink_red}"; echo "BUILD IMG"; echo -e "${restore}";

			cd $RDIR/ramdisk/build
			rm $MODEL-$VARIANT.img

			mv -f $RDIR/ramdisk/30UIN9/image-new.img $RDIR/ramdisk/build/$MODEL-$VARIANT.imgg
			cd $MAINDIR

			
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
        echo "N9 KERNEL"
        echo "build common config="$KERNEL_DEFCONFIGN9 ""
	export PLATFORM_VERSION=11.0.0
	export ANDROID_MAJOR_VERSION=r
	export LOCALVERSION=-$VNR_VER
	MODEL=crownlte

	echo -e "${red}"; echo -e "${blink_red}"; echo "Make IMAGE"; echo -e "${restore}";
	
	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIGN9 || exit -1

	make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	echo -e "${red}"; echo -e "${blink_red}"; echo "Make RAMDISK"; echo -e "${restore}";


	mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
	mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dt

			rm -f $RDIR/ramdisk/30UI/split_img/boot.img-zImage
			rm -f $RDIR/ramdisk/30UI/split_img/boot.img-dt
			mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/ramdisk/30UI/split_img/boot.img-zImage
			mv -f $RDIR/arch/$ARCH/boot/boot.img-dt $RDIR/ramdisk/30UI/split_img/boot.img-dt
			
			cd $RDIR/ramdisk/30UI
			./repackimg.sh --nosudo
			echo SEANDROIDENFORCE >> image-new.img


	echo -e "${red}"; echo -e "${blink_red}"; echo "BUILD IMG"; echo -e "${restore}";

			cd $RDIR/ramdisk/build
			rm $MODEL-$VARIANT.img

			mv -f $RDIR/ramdisk/30UI/image-new.img $RDIR/ramdisk/build/$MODEL-$VARIANT.img
			cd $MAINDIR

			
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_KERNEL"
	echo "================================="
	echo ""
}



function make_zip
{
		cd $RDIR/ramdisk/build
		rm -f `$VNR_ZIP$VNR_Z`
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

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		FUNC_CLEAN_DTB
		echo
		echo "All Cleaned now."
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

echo

while read -p "Do you want to build N960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
	
		echo -e "${red}"; echo -e "${blink_red}"; echo "Start N9 kernel!"; echo -e "${restore}";	
		FUNC_BUILD_KERNELN9
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

echo
echo ""


while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		FUNC_CLEAN_DTB
		echo
		echo "All Cleaned now."
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

echo

while read -p "Do you want to build G965F kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
	
		echo -e "${red}"; echo -e "${blink_red}"; echo "Start S9 Plus kernel!"; echo -e "${restore}";	
		FUNC_BUILD_KERNELS9P
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

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		FUNC_CLEAN_DTB
		echo
		echo "All Cleaned now."
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

echo
while read -p "Do you want to build G960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
	
		echo -e "${red}"; echo -e "${blink_red}"; echo "Start S9 kernel!"; echo -e "${restore}";	
		FUNC_BUILD_KERNELS9
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

echo
	
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
