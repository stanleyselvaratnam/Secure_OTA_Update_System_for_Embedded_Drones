# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : backup-image.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

DESCRIPTION = "Empty ext4 image for backup partition"
LICENSE = "CLOSED"

# Image size in MiB
BACKUP_IMG_SIZE ?= "512"

# Dependencies required for mkfs.ext4
DEPENDS += "e2fsprogs-native"

do_image() {
    IMG=${WORKDIR}/backup.img
    dd if=/dev/zero of=${IMG} bs=1M count=${BACKUP_IMG_SIZE}
    mkfs.ext4 -L backup -O ^has_journal -E lazy_itable_init=0,lazy_journal_init=0 ${IMG}
}

do_deploy() {
    install -Dm0644 ${WORKDIR}/backup.img ${DEPLOY_DIR_IMAGE}/backup.img
}

addtask do_image after do_compile before do_deploy
addtask do_deploy after do_image before do_build
