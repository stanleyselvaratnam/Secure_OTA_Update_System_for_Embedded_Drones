# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : u-boot-distro-boot.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

FILESEXTRAPATHS:prepend:mender-uboot := "${THISDIR}/files:${THISDIR}/files/${TORADEX_BSP_VERSION}:"

SRC_URI += "file://0001-Adapt-boot.cmd.in-to-Mender.patch;patchdir=${WORKDIR};striplevel=0"