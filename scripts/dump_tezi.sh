#!/bin/bash

# Ajouter les partitions de l'image
sudo kpartx -av ~/Téléchargements/Reference-Minimal-Image-imx8mp-verdin/Reference-Minimal-Image-imx8mp-verdin.gptimg

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
