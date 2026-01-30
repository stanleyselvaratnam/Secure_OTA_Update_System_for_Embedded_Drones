# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : ssh-keys.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

DESCRIPTION = "Install authorized SSH keys for root user"
LICENSE = "CLOSED"

SRC_URI = "file://authorized_keys"

do_install() {
    # Create /etc/ssh directory if needed
    install -d ${D}/etc/ssh
    # Copy authorized_keys
    install -m 600 ${WORKDIR}/authorized_keys ${D}/etc/ssh/authorized_keys
}

# Explicitly declare packaged files
FILES:${PN} = "/etc/ssh/authorized_keys"
