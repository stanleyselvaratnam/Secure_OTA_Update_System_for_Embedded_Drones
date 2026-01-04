# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : state-scripts.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

LICENSE = "CLOSED"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "file://Download_Enter_05_rega \
           file://Download_Leave_99_rega \
           file://ArtifactInstall_Enter_10_rega \
           file://ArtifactReboot_Enter_05_rega \
           file://ArtifactCommit_Enter_10_rega"

inherit mender-state-scripts

# Artifact scripts: deploy to /var/lib/mender/scripts
do_compile() {
    cp ${WORKDIR}/ArtifactInstall_Enter_10_rega ${MENDER_STATE_SCRIPTS_DIR}/ArtifactInstall_Enter_10_rega
    cp ${WORKDIR}/ArtifactReboot_Enter_05_rega  ${MENDER_STATE_SCRIPTS_DIR}/ArtifactReboot_Enter_05_rega
    cp ${WORKDIR}/ArtifactCommit_Enter_10_rega  ${MENDER_STATE_SCRIPTS_DIR}/ArtifactCommit_Enter_10_rega
}

# Download scripts: install to rootfs /etc/mender/scripts
do_install() {
    install -d ${D}/etc/mender/scripts
    install -m 0755 ${WORKDIR}/Download_Enter_05_rega  ${D}/etc/mender/scripts/Download_Enter_05_rega
    install -m 0755 ${WORKDIR}/Download_Leave_99_rega  ${D}/etc/mender/scripts/Download_Leave_99_rega
}

FILES:${PN} += "/etc/mender/scripts"
