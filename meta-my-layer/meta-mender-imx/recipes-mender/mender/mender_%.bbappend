# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : mender.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Prepend files directory from this layer to search path
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Add custom source files to SRC_URI
SRC_URI += " \
    file://single-file \
    file://directory \
"

# Override files AFTER standard installation using do_install:append
do_install:append() {
    # Replace official scripts with custom ones
    install -m 0755 ${WORKDIR}/single-file ${D}${datadir}/mender/modules/v3/single-file
    install -m 0755 ${WORKDIR}/directory ${D}${datadir}/mender/modules/v3/directory
}
