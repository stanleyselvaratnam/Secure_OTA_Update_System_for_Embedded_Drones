# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : luks-init_1.0.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

SUMMARY = "LUKS initialization script for secure data partition"
DESCRIPTION = "Initializes and mounts LUKS encrypted partition on first boot"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://luks-init.sh \
           file://luks-init.service"

S = "${WORKDIR}"

RDEPENDS:${PN} = "cryptsetup e2fsprogs util-linux"

inherit systemd

SYSTEMD_SERVICE:${PN} = "luks-init.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    # Install LUKS initialization script
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/luks-init.sh ${D}${sbindir}/luks-init

    # Install systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/luks-init.service ${D}${systemd_system_unitdir}/
}

FILES:${PN} = " \
    ${sbindir}/luks-init \
    ${systemd_system_unitdir}/luks-init.service \
"
