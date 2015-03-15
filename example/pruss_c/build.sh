#!/usr/bin/env sh

export PRU_CGT_DIR=../..

# compile support library without optimization
# enabled to keep argument passing convention

clpru \
--silicon_version=2 \
--hardware_mac=on \
-c \
pru_hal.c


clpru \
--silicon_version=2 \
--hardware_mac=on \
-O3 \
-c \
pru_main.c


# compile and link
# optimizations allowed

clpru \
--silicon_version=2 \
--hardware_mac=on \
-z \
pru_main.obj pru_hal.obj -llibc.a \
-m pru_main.map \
-o pru_main.elf \
$PRU_CGT_DIR/example/AM3359_PRU.cmd


# convert ELF to binary file pru_main.bin

hexpru \
$PRU_CGT_DIR/example/bin.cmd \
./pru_main.elf


# build host program

make clean
make START_ADDR="`./get_start_addr.sh ./pru_main.elf`"
