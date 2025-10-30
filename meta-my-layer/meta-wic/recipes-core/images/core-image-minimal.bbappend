# Utiliser ton fichier WKS pour générer l'image finale
WKS_FILE = "imx8mp-custom.wks"

# Indique à Yocto où chercher le .wks
WKS_FILES_PATHS:append = " ${LAYERDIR}/wic"

# Type d'image à produire
IMAGE_FSTYPES += "wic.gz"

IMAGE_NAME_SUFFIX = "-imx8mp-custom"
