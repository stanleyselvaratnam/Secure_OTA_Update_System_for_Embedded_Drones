# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : tdx-reference-minimal-image.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Use custom WKS file to generate final image
WKS_FILE = "imx8mp-custom.wks"

# Tell Yocto where to find the .wks file
WKS_FILES_PATHS:append = " ${LAYERDIR}/wic"

# Image type to generate
IMAGE_FSTYPES += "wic"

# Custom suffix for image name
IMAGE_NAME_SUFFIX = "-imx8mp-custom"

# Image build dependencies
IMAGE_DEPENDS += "backup-image"
do_image_bootimg[depends] += "u-boot-custom-script:do_deploy"
do_image_bootfs[depends] += "u-boot-custom-script:do_deploy"
do_image_wic[depends] += "tdx-reference-minimal-image:do_image_ext4"
do_image_wic[depends] += "tdx-reference-minimal-image:do_image_dataimg"
do_image_wic[depends] += "tdx-reference-minimal-image:do_image_bootimg"
do_image_wic[depends] += "backup-image:do_image backup-image:do_deploy"

# Ensure required components are built before image
IMAGE_DEPENDS += "imx-atf u-boot-distro-boot device-tree-overlays u-boot-custom-script"
