# meta-my-layer/meta-wic/recipes-core/images/core-image-minimal.bbappend

IMAGE_FSTYPES += "wic wic.bz2 sdimg"

# Vérifie le nom du wks :
WKS_FILE = "custom-qemuarm64.wks.in"
WKS_FILE_DEPENDS += "virtual/kernel"

# Optionnel : assure que wic voie ces variables
# WICVARS += "IMAGE_BOOT_FILES_label-KERNEL_A IMAGE_BOOT_FILES_label-KERNEL_B"

# Ces variables doivent correspondre aux labels EXACTS de ton .wks.in :
IMAGE_BOOT_FILES_label-KERNEL_A = "Image qemuarm64.dtb"
IMAGE_BOOT_FILES_label-KERNEL_B = "Image qemuarm64.dtb"

# Si tu veux un bootloader EFI générique pour QEMU :
IMAGE_BOOT_FILES = "grub-efi-bootaa64.efi"
