# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : tdx-reference-minimal-image.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================


#  Suppression du kernel dans le rootfs (test rollback Mender)

ROOTFS_POSTPROCESS_COMMAND += "remove_kernel_from_rootfs;"

remove_kernel_from_rootfs() {
    echo "== remove-kernel: suppression de Image.gz et Image dans ${IMAGE_ROOTFS}/boot =="

    # Remove standard kernel files
    rm -f ${IMAGE_ROOTFS}/boot/Image.gz || true
    rm -f ${IMAGE_ROOTFS}/boot/Image || true

    # Remove other kernel variants if present in Toradex/Yocto
    rm -f ${IMAGE_ROOTFS}/boot/vmlinuz* || true
    rm -f ${IMAGE_ROOTFS}/boot/zImage || true

    # remove dtb for more severe failure simulation
    # rm -f ${IMAGE_ROOTFS}/boot/*.dtb || true
}
