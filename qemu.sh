#!/usr/bin/env bash

set -e

if [[ -z "$1" ]]; then
    echo "supply an executable name"
    exit
fi


# RPi0
# echo 'rpi0'
# qemu-system-aarch64 -m 512M -M raspi0 -serial mon:stdio -nographic -S -s -kernel "$1"

# RPi1
# echo 'rpi1'
# qemu-system-aarch64 -m 512M -M raspi1ap -serial mon:stdio -nographic -S -s -kernel "$1"

# RPi2
echo 'rpi2'
qemu-system-aarch64 -m 1G -M raspi2b -cpu cortex-a72 -smp 4 -serial mon:stdio -nographic -S -s
    -dtb "$HOME/projects/rtems/rpi-firmware-1.20200601/boot/bcm2710-rpi-2-b.dtb" \
    -kernel "$1"

# RPi3
# echo 'rpi3'
# qemu-system-aarch64 -m 1G -M raspi3b -cpu cortex-a72 -smp 4 -serial mon:stdio -nographic -S -s \
#     -dtb "$HOME/projects/rtems/rpi-firmware-1.20200601/boot/bcm2710-rpi-3-b-plus.dtb" \
#     -kernel "$1"

    # -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" \
    # -sd ./2022-04-04-raspios-bullseye-armhf.img
