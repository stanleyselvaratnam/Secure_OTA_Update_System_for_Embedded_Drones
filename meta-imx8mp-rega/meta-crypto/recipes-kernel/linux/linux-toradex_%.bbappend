# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : linux-toradex_%.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Prepend path to custom kernel configuration files
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Add dm-crypt for LUKS and dm-verity for integrity support
SRC_URI += " \
    file://dm-crypt.cfg \
    file://dm-verity.cfg \
"
