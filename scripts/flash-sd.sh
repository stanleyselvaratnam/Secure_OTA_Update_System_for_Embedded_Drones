#!/bin/bash

set -e

# Variables - adapter selon tes fichiers et périphérique SD
SD_DEVICE="/dev/sda"                   # Remplace sdX par le bon périphérique (ex: sdb)
WIC_IMAGE="../build-imx8mp/tmp/deploy/images/verdin-imx8mp/Verdin-iMX8MP_Reference-Minimal-Image.wic"
UBOOT_BIN="../build-imx8mp/tmp/deploy/images/verdin-imx8mp/u-boot-verdin-imx8mp.bin"
BOOT_SCRIPT_1="../build-imx8mp/tmp/deploy/images/verdin-imx8mp/boot.scr"
BOOT_SCRIPT_2="../build-imx8mp/tmp/deploy/images/verdin-imx8mp/my_custom_boot.scr"

echo "== Nettoyage des montages éventuels =="
# Trouver et démonter toutes les partitions montées de la SD, sans doublons
MOUNTPOINTS=$(lsblk -nr -o MOUNTPOINT ${SD_DEVICE}* | grep -v '^$' | sort -u || true)
if [ -n "$MOUNTPOINTS" ]; then
    echo "Démontage des partitions montées :"
    echo "$MOUNTPOINTS"
    for mnt in $MOUNTPOINTS; do
        echo "  umount $mnt"
        sudo umount -l "$mnt" || echo "Le démontage de $mnt a échoué"
    done
else
    echo "Aucun point de montage détecté pour ${SD_DEVICE}"
fi

echo "== Désactivation du swap sur la SD si existant =="
# Désactiver le swap sur les partitions de la SD
SWAPS=$(cat /proc/swaps | grep "${SD_DEVICE}" || true)
if [ -n "$SWAPS" ]; then
    echo "Désactivation des swap suivant :"
    echo "$SWAPS"
    sudo swapoff -a
else
    echo "Aucun swap détecté sur ${SD_DEVICE}"
fi

echo "== Repartitionnement et formatage optionnels =="
read -rp "Veux-tu repartitionner et formater la carte SD (toutes données perdues) ? (o/N) " yn
if [[ $yn =~ ^[Oo]$ ]]; then
    echo "Création d'une table MBR et d'une unique partition FAT32..."
    sudo parted --script "$SD_DEVICE" \
        mklabel msdos \
        mkpart primary fat32 1MiB 100% \
        set 1 boot on

    PARTITION="${SD_DEVICE}1"
    echo "Formatage de ${PARTITION} en FAT32..."
    sudo mkfs.vfat -F 32 "$PARTITION"
else
    echo "Repartitionnement et formatage ignorés."
fi

echo "== Flashage du .wic sur ${SD_DEVICE} =="
sudo dd if="${WIC_IMAGE}" of="${SD_DEVICE}" bs=16M conv=fsync status=progress

echo "== Flashage du U-Boot custom dans la zone bootloader =="
sudo dd if="${UBOOT_BIN}" of="${SD_DEVICE}" bs=1K seek=1 conv=fsync status=progress

echo "== Vérification et éventuelle réparation de la table GPT =="
GPT_CHECK=$(sudo parted "$SD_DEVICE" print 2>&1 | grep -i "corrompues\|corrupted" || true)
if [ -n "$GPT_CHECK" ]; then
    echo "Table GPT corrompue détectée, tentative de réparation avec parted rescue..."
    sudo parted "$SD_DEVICE" rescue
fi

echo "== Mise à jour des partitions et montage partition boot =="
sudo partprobe "${SD_DEVICE}"
sleep 3

BOOT_PARTITION="${SD_DEVICE}1"
MOUNT_POINT="/mnt/boot_temp"
sudo mkdir -p "${MOUNT_POINT}"
sudo mount "${BOOT_PARTITION}" "${MOUNT_POINT}"

echo "== Copie des scripts de boot dans la partition boot =="
sudo cp "${BOOT_SCRIPT_1}" "${BOOT_SCRIPT_2}" "${MOUNT_POINT}/"
sync

echo "== Démontage de la partition boot =="
sudo umount "${MOUNT_POINT}"
sudo rmdir "${MOUNT_POINT}"

echo "== Flashage terminé. Vérifie ta carte SD avant utilisation =="
