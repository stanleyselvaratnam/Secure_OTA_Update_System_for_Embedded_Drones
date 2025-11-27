SUMMARY = "Generate boot-loader.scr from boot.cmd.in"
LICENSE = "CLOSED"

SRC_URI = "file://boot.cmd.in"
S = "${WORKDIR}"
DEPENDS = "u-boot-mkimage-native"

inherit deploy

do_compile() {
    # Copie le fichier source (tu peux ajouter sed pour des substitutions si nécessaire)
    cp ${WORKDIR}/boot.cmd.in boot.cmd
}

do_deploy() {
    # Génère le boot-loader.scr dans le dossier de déploiement
    mkimage -A arm64 -T script -C none -n "Custom Boot Script" -d boot.cmd boot-loader.scr
    install -m 0644 boot-loader.scr ${DEPLOY_DIR_IMAGE}/boot-loader.scr
}

addtask deploy after do_compile before do_build
