# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : mender-cert.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

SUMMARY = "Mender server certificate"
LICENSE = "CLOSED"

# Include local files (mender.crt)
FILESEXTRAPATHS:prepend := "${THISDIR}/../files:"

SRC_URI = "file://mender.crt"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/mender
    install -m 0644 ${WORKDIR}/mender.crt ${D}${sysconfdir}/mender/server.crt
}

FILES:${PN} += "${sysconfdir}/mender/server.crt"
