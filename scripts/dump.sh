#!/bin/bash

# Ajouter les partitions de l'image
sudo kpartx -av ../build-rpi4/tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.gptimg

# Monter chaque partition et lister son contenu
for part in /dev/mapper/loop0p*; do
    echo "=== Partition $part ==="
    sudo mount "$part" /mnt
    ls /mnt
    sudo umount /mnt
done

# Supprimer les mappings des partitions
sudo kpartx -d /dev/loop0
sudo losetup -d /dev/loop0
