# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : binutils_2.42.bbappend
# Author  : Stanley Selvaratnam
# Target  : Raspberry Pi 4 Model B
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Disable gold and gprofng to prevent crashes on aarch64
EXTRA_OECONF:append:armv8a = " --disable-gold --disable-gprofng"
