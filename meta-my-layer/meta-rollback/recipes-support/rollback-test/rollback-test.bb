SUMMARY = "Test rollback Mender via script d'état"
DESCRIPTION = "Force le rollback Mender en échouant explicitement la phase commit de l'OTA."
LICENSE = "CLOSED"

SRC_URI = "file://ArtifactCommit_Enter"

inherit mender-state-scripts

do_install() {
    install -d ${D}${MENDER_STATE_SCRIPTS_DIR}
    install -m 0755 ${WORKDIR}/ArtifactCommit_Enter ${D}${MENDER_STATE_SCRIPTS_DIR}/ArtifactCommit_Enter_50
}

FILES:${PN} += "${MENDER_STATE_SCRIPTS_DIR}/ArtifactCommit_Enter_50"
