# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : u-boot-custom-script.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

SUMMARY = "Generate boot-loader.scr from boot.cmd.in"
LICENSE = "CLOSED"

SRC_URI = "file://boot.cmd.in"
S = "${WORKDIR}"
DEPENDS = "u-boot-mkimage-native"

inherit deploy

do_compile() {
    # Copy source file (add sed substitutions if needed)
    cp ${WORKDIR}/boot.cmd.in boot.cmd
}

do_deploy() {
    # Generate boot-loader.scr for deployment
    mkimage -A arm64 -T script -C none -n "Custom Boot Script" -d boot.cmd boot-loader.scr
    install -m 0644 boot-loader.scr ${DEPLOY_DIR_IMAGE}/boot-loader.scr
}

addtask deploy after do_compile before do_build
