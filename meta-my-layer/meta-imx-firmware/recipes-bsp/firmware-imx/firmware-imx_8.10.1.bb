SUMMARY = "i.MX8 LPDDR4 firmware deployer"
DESCRIPTION = "Copy pre-extracted LPDDR4 firmware for i.MX8 into deploy/images"
LICENSE = "CLOSED"

S = "${WORKDIR}"

# Pas de téléchargement, les fichiers sont déjà dans files/
do_compile() {
    # Crée le dossier deploy/images si absent
    install -d ${DEPLOY_DIR_IMAGE}

    # Copie tous les fichiers LPDDR4 dans le deploy directory
    cp ${THISDIR}/files/firmware-imx-8.10.1/firmware/ddr/synopsys/lpddr4*_202006.bin ${DEPLOY_DIR_IMAGE}/
}

# Pas de packaging ni warnings ldflags
INSANE_SKIP_${PN} = "ldflags"
