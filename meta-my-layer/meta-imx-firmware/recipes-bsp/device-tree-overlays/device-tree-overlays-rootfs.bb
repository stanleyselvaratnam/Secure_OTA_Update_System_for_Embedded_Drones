SUMMARY = "Copie overlays et overlays.txt depuis le dossier deploy vers /boot du rootfs"
LICENSE = "CLOSED"

# Pas besoin de mettre overlays.txt dans SRC_URI puisqu'on le prend aussi depuis deploy

do_install() {
    # Création du dossier overlays dans /boot du rootfs
    install -d ${D}/boot/overlays

    # Copier overlays.txt depuis le dossier deploy
    install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt ${D}/boot/

    # Copier tout le contenu du dossier overlays depuis deploy vers /boot/overlays
    cp -r ${DEPLOY_DIR_IMAGE}/overlays/* ${D}/boot/overlays/
}

FILES:${PN} = " \
    /boot/overlays/*.dtbo \
    /boot/overlays \
    /boot/overlays.txt \
"
