# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : mender.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Include local files (mender.conf and kernel module)
FILESEXTRAPATHS:prepend := "${THISDIR}/../files:"

# Add files to copy
SRC_URI:append = " \
    file://mender.conf \
    file://kernel \
"

# Install files to final image
do_install:append() {
    # --- Install mender.conf ---
    install -d ${D}${sysconfdir}/mender
    install -m 0644 ${WORKDIR}/mender.conf ${D}${sysconfdir}/mender/mender.conf

    # --- Install custom kernel module ---
    install -d ${D}${datadir}/mender/modules/v3
    install -m 0755 ${WORKDIR}/kernel ${D}${datadir}/mender/modules/v3/kernel
}
