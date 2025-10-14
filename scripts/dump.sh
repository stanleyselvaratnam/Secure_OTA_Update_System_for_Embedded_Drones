#/bin/bash
sudo kpartx -av ../build/tmp/deploy/images/raspberrypi4-64/core-image-minimal-raspberrypi4-64.sdimg

sudo umount /mnt
sudo mount /dev/mapper/loop0p1 /mnt && ls /mnt && sudo umount /mnt
sudo mount /dev/mapper/loop0p2 /mnt && ls /mnt && sudo umount /mnt
sudo mount /dev/mapper/loop0p3 /mnt && ls /mnt && sudo umount /mnt
sudo mount /dev/mapper/loop0p4 /mnt && ls /mnt && sudo umount /mnt
# sudo mount /dev/mapper/loop0p5 /mnt && ls /mnt && sudo umount /mnt
# sudo mount /dev/mapper/loop0p6 /mnt && ls /mnt && sudo umount /mnt

sudo kpartx -d /dev/loop0
