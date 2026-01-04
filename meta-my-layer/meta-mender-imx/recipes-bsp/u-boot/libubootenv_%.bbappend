# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : libubootenv.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://fw_env.config"

do_install:append() {
    # Install to /data/u-boot as Mender expects
    install -d ${D}/data/u-boot
    install -m 0644 ${WORKDIR}/fw_env.config ${D}/data/u-boot/fw_env.config

    # Create symlink /etc/fw_env.config
    install -d ${D}${sysconfdir}
    ln -sf /data/u-boot/fw_env.config ${D}${sysconfdir}/fw_env.config
}
