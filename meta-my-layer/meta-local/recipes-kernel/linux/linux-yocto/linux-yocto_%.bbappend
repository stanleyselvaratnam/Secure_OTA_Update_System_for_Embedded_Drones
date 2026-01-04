# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : linux-yocto.bbappend
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Prepend files directory to search path
FILESEXTRAPATHS:prepend := "${THISDIR}/../files:"

# Add custom Device Tree Source
SRC_URI:append = " file://qemuarm64.dts"

# Copy DTS to kernel source tree during configure (qemuarm64)
do_configure:append:qemuarm64() {
    install -m 0644 ${WORKDIR}/qemuarm64.dts ${S}/arch/arm64/boot/dts/qemuarm64.dts
    echo "dtb-\$(CONFIG_ARM64) += qemuarm64.dtb" >> ${S}/arch/arm64/boot/dts/Makefile
}

# Add DTB to kernel image
KERNEL_DEVICETREE:append:qemuarm64 = " qemuarm64.dtb"
