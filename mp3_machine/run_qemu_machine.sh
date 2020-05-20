#!/bin/bash
qemu-system-arm \
  -M versatilepb \
  -kernel output/images/zImage \
  -dtb output/images/versatile-pb.dtb \
  -drive file=output/images/rootfs.ext2,if=scsi,format=raw \
  -append "root=/dev/sda console=ttyAMA0,115200" \
  -serial stdio \
  -device rtl8139,netdev=net0 \
  -netdev user,id=net0,net=192.168.1.0/24,hostfwd=tcp::2222-:22 \
  -name Versatile_ARM_EXT2
