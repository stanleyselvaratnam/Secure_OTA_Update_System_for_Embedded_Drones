# Append au paquet linux-firmware-rpidistro
# pour appliquer le patch corrigeant les liens symboliques du firmware brcmfmac43455

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0002-Default-all-RPi-43455-boards-to-standard-variant.patch"

# On applique le patch avant compilation
do_patch[depends] += "patch-native:do_populate_sysroot"
