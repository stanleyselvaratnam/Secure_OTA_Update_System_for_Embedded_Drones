# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : wpa-supplicant-wifi.bb
# Author  : Stanley Selvaratnam
# Target  : Raspberry Pi 4 Model B
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

DESCRIPTION = "Wi-Fi configuration for Raspberry Pi"
LICENSE = "CLOSED"

SRC_URI = "file://wpa_supplicant-wlan0.conf"

S = "${WORKDIR}"

inherit systemd

# Enable wpa_supplicant@wlan0 and dhcpcd services at boot
SYSTEMD_SERVICE:${PN} = "wpa_supplicant@wlan0.service dhcpcd.service"
SYSTEMD_AUTO_ENABLE = "enable"

do_install() {
    # Create wpa_supplicant directory
    install -d ${D}/etc/wpa_supplicant
    # Install custom wpa_supplicant config
    install -m 600 ${WORKDIR}/wpa_supplicant-wlan0.conf ${D}/etc/wpa_supplicant/wpa_supplicant-wlan0.conf

    # Remove global generic config to avoid boot conflicts
    rm -f ${D}/etc/wpa_supplicant.conf

    # Create systemd symlink to force service activation at boot
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
    ln -sf ${systemd_unitdir}/system/wpa_supplicant@.service \
        ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
}

FILES:${PN} = "/etc/wpa_supplicant/wpa_supplicant-wlan0.conf"
