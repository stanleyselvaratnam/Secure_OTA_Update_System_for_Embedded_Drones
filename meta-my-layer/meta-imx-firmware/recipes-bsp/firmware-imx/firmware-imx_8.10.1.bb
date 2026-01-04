# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : firmware-imx_8.10.1.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

SUMMARY = "i.MX8 LPDDR4 firmware deployer"
DESCRIPTION = "Copy pre-extracted LPDDR4 firmware for i.MX8 into deploy/images"
LICENSE = "CLOSED"

S = "${WORKDIR}"

# No source download, files already in files/
do_compile() {
    # Create deploy/images directory if missing
    install -d ${DEPLOY_DIR_IMAGE}

    # Copy all LPDDR4 firmware files to deploy directory
    cp ${THISDIR}/files/firmware-imx-8.10.1/firmware/ddr/synopsys/lpddr4*_202006.bin ${DEPLOY_DIR_IMAGE}/
}

# Skip packaging and ldflags warnings
INSANE_SKIP:${PN} = "ldflags"
