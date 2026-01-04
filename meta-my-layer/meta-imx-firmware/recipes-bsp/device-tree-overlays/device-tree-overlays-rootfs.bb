# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : device-tree-overlays-rootfs.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

SUMMARY = "Copy overlays and overlays.txt from deploy to rootfs /boot"
LICENSE = "CLOSED"

do_install() {
    # Create overlays directory in rootfs /boot
    install -d ${D}/boot/overlays

    # Copy overlays.txt from deploy directory
    install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt ${D}/boot/

    # Copy all overlays from deploy to rootfs /boot/overlays
    cp -r ${DEPLOY_DIR_IMAGE}/overlays/* ${D}/boot/overlays/
}

FILES:${PN} = " \
    /boot/overlays/*.dtbo \
    /boot/overlays \
    /boot/overlays.txt \
"
