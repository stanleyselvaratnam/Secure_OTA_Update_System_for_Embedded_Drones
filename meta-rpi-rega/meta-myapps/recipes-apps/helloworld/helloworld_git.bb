# ==============================================================================
# Project : Secure Embedded Linux OTA System (REGA)
# File    : helloworld_git.bb
# Author  : Stanley Selvaratnam
# Target  : Toradex Verdin iMX8MP
# Yocto   : Custom layer / recipe
# Email   : stanley.selvaratnam@gmail.com
# ==============================================================================

# Clones source from GitHub, compiles binary and installs to /usr/bin

# Brief recipe description
SUMMARY = "Simple Hello World app"

# Software license (required by BitBake)
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=33ef8b00d7f1a720a56a6d80ab7358a1"

# GitHub repository URL containing application source code
# 'branch=main' specifies branch to use
SRC_URI = "git://github.com/stanleyselvaratnam/HelloWorld.git;protocol=https;branch=main"
SRCREV = "AUTOINC"

# Source directory after BitBake clones repository
S = "${WORKDIR}/git"


# Uses BitBake-provided cross-compiler
do_compile() {
    oe_runmake CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

# Installs binary to BitBake temporary filesystem
do_install() {
    oe_runmake install DESTDIR=${D}
}

# Binary goes to /usr/bin/helloworld
FILES:${PN} = "/usr/bin/helloworld"
