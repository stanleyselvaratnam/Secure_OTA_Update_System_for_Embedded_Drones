FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://crypttab \
    file://fstab.append \
"

do_install:append() {
    # Install crypttab
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/crypttab ${D}${sysconfdir}/crypttab

    # Append fstab entry
    cat ${WORKDIR}/fstab.append >> ${D}${sysconfdir}/fstab
}
