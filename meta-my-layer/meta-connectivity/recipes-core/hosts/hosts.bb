# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : hosts.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

DESCRIPTION = "Custom /etc/hosts file with Mender server entries"
LICENSE = "CLOSED"

SRC_URI = "file://hosts"

do_install() {
    # Create /etc directory
    install -d ${D}/etc
    # Install custom hosts file
    install -m 0644 ${WORKDIR}/hosts ${D}/etc/hosts
}

FILES:${PN} = "/etc/hosts"
