# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : base-files_%.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

DESCRIPTION = "Custom /etc/hosts file with Mender server entries"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://hosts"

do_install:append() {
    # Install custom hosts file with Mender server entries
    install -m 0644 ${WORKDIR}/hosts ${D}${sysconfdir}/hosts
}
