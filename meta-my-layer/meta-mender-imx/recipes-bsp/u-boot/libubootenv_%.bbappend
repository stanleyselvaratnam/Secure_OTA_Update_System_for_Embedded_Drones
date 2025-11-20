# libubootenv_%.bbappend

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://fw_env.config"

# --- ÉTAPE 1 : écraser fw_env.config.default dans DEPLOY_DIR_IMAGE ---
do_deploy:append() {
    echo ">>> Forcing custom fw_env.config.default into DEPLOY_DIR_IMAGE"
    install -m 0644 ${WORKDIR}/fw_env.config ${DEPLOY_DIR_IMAGE}/fw_env.config.default
}

# --- ÉTAPE 2 : forcer notre fichier dans le rootfs (après tout le monde) ---
ROOTFS_POSTPROCESS_COMMAND += "rewrite_fw_env_config;"

rewrite_fw_env_config() {
    echo ">>> Rewriting fw_env.config in ROOTFS"

    install -d -m 755 ${IMAGE_ROOTFS}/data/u-boot
    install -m 0644 ${WORKDIR}/fw_env.config ${IMAGE_ROOTFS}/data/u-boot/fw_env.config

    rm -f ${IMAGE_ROOTFS}/etc/fw_env.config
    ln -sf /data/u-boot/fw_env.config ${IMAGE_ROOTFS}/etc/fw_env.config
}
