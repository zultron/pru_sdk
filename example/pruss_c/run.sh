#!/bin/bash
#
# This program should be run as root
#
/sbin/modprobe uio_pruss
echo BB-BONE-PRU-01 > /sys/devices/bone_capemgr.9/slots
./main
