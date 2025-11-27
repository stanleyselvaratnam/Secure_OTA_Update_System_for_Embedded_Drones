# Utiliser ton fichier WKS pour générer l'image finale
WKS_FILE = "imx8mp-custom.wks"

# Indique à Yocto où chercher le .wks
WKS_FILES_PATHS:append = " ${LAYERDIR}/wic"

# Type d'image à produire
IMAGE_FSTYPES += "wic"

IMAGE_NAME_SUFFIX = "-imx8mp-custom"

# Dépendances de construction de l'image
IMAGE_DEPENDS += "backup-image"
do_image_bootimg[depends] += "u-boot-custom-script:do_deploy"
do_image_bootfs[depends] += "u-boot-custom-script:do_deploy"
do_image_wic[depends] += "tdx-reference-minimal-image:do_image_ext4"
do_image_wic[depends] += "tdx-reference-minimal-image:do_image_dataimg"
do_image_wic[depends] += "tdx-reference-minimal-image:do_image_bootimg"
do_image_wic[depends] += "backup-image:do_image backup-image:do_deploy"

# Dépendances pour que les fichiers nécessaires existent avant le build de l'image
IMAGE_DEPENDS += "imx-atf u-boot-distro-boot device-tree-overlays u-boot-custom-script"
