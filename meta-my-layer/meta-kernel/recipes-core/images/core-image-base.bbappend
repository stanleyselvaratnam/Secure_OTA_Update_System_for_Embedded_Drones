# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : core-image-base.bbappend
# Author  : Stanley Selvaratnam
# Target  : Raspberry Pi 4 Model B
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Enable Mender kernel image support for REGA OTA
require conf/include/mender-kernel-image.inc


# meta-my-layer/meta-kernel/recipes-core/images/core-image-base.bbappend

require conf/include/mender-kernel-image.inc
