# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : secure-symlinks.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

SUMMARY = "Sync sensitive files to encrypted partition and create symlinks"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://sync-secure-files.sh \
           file://mapping.list \
           file://sync-secure-files.service"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} = "sync-secure-files.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    # Install file mapping list
    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/mapping.list ${D}${sysconfdir}/mapping.list
    
    # Install sync script
    install -d ${D}${sbindir}
    install -m 755 ${WORKDIR}/sync-secure-files.sh ${D}${sbindir}/sync-secure-files.sh
    
    # Install systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/sync-secure-files.service ${D}${systemd_system_unitdir}/sync-secure-files.service
}

