SUMMARY = "Mender public key package"
DESCRIPTION = "Installs the main Mender public key (.pem) for artifact verification"
LICENSE = "CLOSED"
PR = "r1"

# Ajoute cette dépendance pour que openssl soit dispo dans le sysroot
DEPENDS = "openssl-native"

SRC_URI = "file://public.key"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/mender
    # Conversion de .key → .pem pour le client Mender
    ${STAGING_BINDIR_NATIVE}/openssl rsa -in ${WORKDIR}/public.key -pubin -outform PEM \
        -out ${D}${sysconfdir}/mender/artifact-verify-key.pem
}

FILES_${PN} = "${sysconfdir}/mender/artifact-verify-key.pem"
