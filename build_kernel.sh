#!/bin/bash

DATE=$(date +%m%d)
rm "$DATE"_test_*.zip
#rm -rf ../initramfs/.git
#rm -rf ../voodoo_initramfs/.git

for CONFIG in novoodoo
do
	make mrproper
	make clean
	rm update/*.zip update/kernel_update/zImage

	make ARCH=arm geeknik_"$CONFIG"_defconfig
#	make -j8 CROSS_COMPILE=../arm-2009q3/bin/arm-none-linux-gnueabi- \
#       make -j8 CROSS_COMPILE=../arm-cortex/bin/arm-cortex_a8-linux-gnueabi- \
        make -j8 CROSS_COMPILE=../arm-cortex2/bin/arm-cortex_a8_kandroid-linux-uclibcgnueabi- \
		ARCH=arm HOSTCFLAGS="-g -O3"

	cp arch/arm/boot/zImage update/kernel_update/zImage
	cd update
	zip -r kernel_update.zip . 
	mv kernel_update.zip ../"$DATE"_test_"$CONFIG".zip
	cd ..
done
