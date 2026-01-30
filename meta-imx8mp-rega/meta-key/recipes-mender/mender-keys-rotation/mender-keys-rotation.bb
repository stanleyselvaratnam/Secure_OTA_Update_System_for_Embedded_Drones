SUMMARY = "Mender rotation public key package"
DESCRIPTION = "Installs the rotation Mender public key (.pem) for artifact verification"
LICENSE = "CLOSED"
PR = "r1"

DEPENDS = "openssl-native"

SRC_URI = "file://public-rotation.key"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/mender
    ${STAGING_BINDIR_NATIVE}/openssl rsa -in ${WORKDIR}/public-rotation.key -pubin -outform PEM \
        -out ${D}${sysconfdir}/mender/artifact-verify-key-rotation.pem
}

FILES_${PN} = "${sysconfdir}/mender/artifact-verify-key-rotation.pem"
