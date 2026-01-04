# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : openssh.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Prepend path to our custom files
FILESEXTRAPATHS:prepend := "${THISDIR}/openssh:"

# Add custom sshd_config file
SRC_URI += "file://sshd_config"

# Install the custom file in place of the system one
do_install:append() {
    install -d ${D}/etc/ssh
    install -m 600 ${WORKDIR}/sshd_config ${D}/etc/ssh/sshd_config
}
