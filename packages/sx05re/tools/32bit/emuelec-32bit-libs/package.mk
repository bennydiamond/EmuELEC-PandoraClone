# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="emuelec-32bit-libs"
PKG_VERSION="8e53ca0df4de3a86f9c7d04952b41f25d3396932"
PKG_SHA256="1a273909baaf10d5abf28dc18bf60d63662113c66d9d6d316ae463253c5c7e8c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/emuelec/emuelec-32bit-libs"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain $OPENGLES"
PKG_LONGDESC="EmuELEC 32-bit libraries, binaries and cores to use with EmuELEC aarch64"
PKG_TOOLCHAIN="manual"
#PKG_VERSION_PATH="r7p0/fbdev"
PKG_VERSION_PATH="r5p1"

makeinstall_target() {
  mkdir -p ${INSTALL}
  # Amlogic
  cp -rf ${PKG_BUILD}/Amlogic-old/* ${INSTALL}/
  cp -p "$(get_build_dir opengl-meson)/lib/eabihf/m450/$PKG_VERSION_PATH/libMali.so" ${INSTALL}/usr/config/emuelec/lib32/libMali.m450.so

mkdir -p ${INSTALL}/usr/lib
ln -sf /emuelec/lib32 ${INSTALL}/usr/lib/arm-linux-gnueabihf
ln -sf /emuelec/lib32/ld-linux-armhf.so.3 ${INSTALL}/usr/lib/ld-linux-armhf.so.3

mkdir -p ${INSTALL}/usr/lib/libretro
cp ${PKG_DIR}/infos/*.info ${INSTALL}/usr/lib/libretro/
}
