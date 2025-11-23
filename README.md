# Travail Master — Yocto Project with OTA Updates

## Introduction

This project is part of the Master’s thesis and focuses on building a complete embedded Linux system using the Yocto Project. The system is designed to run on multiple hardware platforms:

* QEMU ARM64 (emulated environment)
* Raspberry Pi 4
* Toradex Verdin iMX8MP

The main objective is to establish a reproducible build environment and validate system images across various platforms.
The project also aims to integrate a robust OTA update mechanism using Mender to ensure long-term maintainability of the embedded system.

---

## Docker Environment

The project uses a container based on:
`FROM crops/yocto:ubuntu-22.04-base`

Example command to start the Docker environment:

```bash
docker run --rm -it -v ~/Documents/TM/yocto:/workdir testyocto --workdir=/workdir
```

This container includes all required tools for building Yocto images.

---

## Building the Different Platforms

The project supports Yocto builds for three platforms. Each platform is built using a dedicated `kas` configuration file.

### 1. QEMU ARM64

Used for initial tests and validation in a controlled environment.

Example build command:

```bash
KAS_BUILD_DIR=build-arm64 kas build kas_qemuarm64.yml
```

### 2. Raspberry Pi 4

Used as a real hardware test platform to validate OTA updates with Mender.

Example build command:

```bash
KAS_BUILD_DIR=build-rpi4 kas build kas_rpi.yml
```

### 3. Toradex Verdin iMX8MP

The final target platform for the drone system used by Rega.
Tests include integrating Mender and managing the bootloader.

Example build command:

```bash
KAS_BUILD_DIR=build-imx8mp kas build kas_imx8mp.yml
```

---

## OTA Update Objective

The project integrates Mender to provide a reliable OTA update mechanism with:

* A/B partition-based rollback
* Robust update handling suitable for embedded systems

Advanced security features (such as Secure Boot or full disk encryption) are not part of the current project phase and will be addressed later.

---

## Yocto Layers and Commit References

Below is the complete list of Yocto layers used in the project, including their branches and exact commit references, to ensure full reproducibility of the builds:

```bash
meta-arm:
  Branch: scarthgap
  Commit: a81c19915b5b9e71ed394032e9a50fd06919e1cd
meta-arm-bsp:
  Branch: scarthgap
  Commit: a81c19915b5b9e71ed394032e9a50fd06919e1cd
meta-arm-toolchain:
  Branch: scarthgap
  Commit: a81c19915b5b9e71ed394032e9a50fd06919e1cd
meta-freescale:
  Branch: scarthgap
  Commit: 7d83a350d8b28498321a481a2a1c51bb4afb48e9
meta-freescale-3rdparty:
  Branch: scarthgap
  Commit: 70c83e96c7f75e73245cb77f1b0cada9ed4bbc6d
meta-freescale-distro:
  Branch: scarthgap
  Commit: b9d6a5d9931922558046d230c1f5f4ef6ee72345
meta-lts-mixins:
  Branch: scarthgap/u-boot
  Commit: a44882db02a0ed0f149371831bfbe067665eb42b
meta-mender-core:
  Branch: scarthgap
  Commit: 6818fa87fdee9e3873ec797cb63a3dda5b49b608
meta-connectivity:
  Branch: master
  Commit: 196f7199f4c27bcdb8ba95781b215fafa96ad48c
meta-custom-u-boot:
  Branch: master
  Commit: 196f7199f4c27bcdb8ba95781b215fafa96ad48c
meta-local:
  Branch: master
  Commit: 196f7199f4c27bcdb8ba95781b215fafa96ad48c
meta-mender-imx:
  Branch: master
  Commit: 196f7199f4c27bcdb8ba95781b215fafa96ad48c
meta-mender-toradex-nxp:
  Branch: master
  Commit: 196f7199f4c27bcdb8ba95781b215fafa96ad48c
meta-wic:
  Branch: master
  Commit: 196f7199f4c27bcdb8ba95781b215fafa96ad48c
meta-filesystems:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-gnome:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-multimedia:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-networking:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-oe:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-perl:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-python:
  Branch: scarthgap
  Commit: 15e18246dd0c0585cd1515a0be8ee5e2016d1329
meta-qt5:
  Branch: scarthgap
  Commit: e197839013fa2cfd59339508303bce91fef48928
meta-security:
  Branch: scarthgap
  Commit: bc865c5276c2ab4031229916e8d7c20148dfbac3
meta-tpm:
  Branch: scarthgap
  Commit: bc865c5276c2ab4031229916e8d7c20148dfbac3
meta-ti-bsp:
  Branch: scarthgap
  Commit: 5b095d968eb225b72e44dc164683aa9157ec2b93
meta-ti-extras:
  Branch: scarthgap
  Commit: 5b095d968eb225b72e44dc164683aa9157ec2b93
meta-toradex-bsp-common:
  Branch: scarthgap-7.x.y
  Commit: 08d8c39707936895d26767156654226f342c4e8a
meta-toradex-demos:
  Branch: scarthgap-7.x.y
  Commit: 4ba1cebc6909ee7a83d569e8cc748f69e6a0a24f
meta-toradex-distro:
  Branch: scarthgap-7.x.y
  Commit: 71f3887a63d9b10b925afd75d6fb00085cd420b3
meta-toradex-nxp:
  Branch: scarthgap-7.x.y
  Commit: c8b1e7c44c930edd8ff889ad01ab4a5f636948d8
meta-toradex-security:
  Branch: scarthgap-7.x.y
  Commit: 66954a4745d4ba880f00addb31a18105bc20aab4
meta-toradex-ti:
  Branch: scarthgap-7.x.y
  Commit: 699cbb557f3c5e57dbdffa2c2023993ee081cf07
meta:
  Branch: scarthgap
  Commit: b33a8abe77081a2bdda0d89c61736473b2f9bb8b
meta-poky:
  Branch: scarthgap
  Commit: b33a8abe77081a2bdda0d89c61736473b2f9bb8b
meta-yocto-bsp:
  Branch: scarthgap
  Commit: b33a8abe77081a2bdda0d89c61736473b2f9bb8b
```
