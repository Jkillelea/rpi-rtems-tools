#!/usr/bin/env bash

set -e

if [[ -z "$1" ]]; then
    echo "supply an executable name"
    exit
fi

GDB="$HOME/projects/rtems/6/bin/arm-rtems6-gdb"

# echo "rpi3"
# ADDR="0x2ef00000"
# DTB="bcm2710-rpi-3-b-plus.dtb"

# echo "rpi2"
ADDR="0x2ef00000"
DTB="bcm2709-rpi-2-b.dtb"
# DTB="bcm2710-rpi-2-b.dtb"

# echo "rpi1"
# ADDR="0x20008da"
# DTB="bcm2708-rpi-zero.dtb"

$GDB \
    -tui \
    -ex 'target extended-remote localhost:1234' \
    -ex 'load' \
    -ex "restore $HOME/projects/rtems/rpi-firmware-1.20200601/boot/$DTB binary $ADDR" \
    -ex "set \$r2 = $ADDR" \
    -ex 'b rtems_fatal' \
    "$1"
    # -ex "set scheduler-locking on" \
    # -ex 'b arm_cp15_set_control' \
    # -ex 'b rtems_initialize_executive' \
    # -ex 'b bsp_start' \
    # -ex 'b Init' \
    # -ex 'b bsp_start_hook_0' \
    # -ex 'b _start' \
    # -ex 'b _Chain_Is_node_off_chain' \

if [ $? ]; then
    pkill qemu-system
fi
