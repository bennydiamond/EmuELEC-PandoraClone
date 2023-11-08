# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Arthur Liberman (arthur_liberman@hotmail.com)

PKG_NAME="pandoracloneencoderdriver"
PKG_VERSION="v0.0.1"
PKG_SHA256="043f87aae7e43282351fbc322d6ca7349d1f26653b1630607e16ef3f98021d7d"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/bennydiamond/pandoracloneencoderdriver"
PKG_URL="https://github.com/bennydiamond/pandoracloneencoderdriver/archive/refs/tags/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="pandoracloneencoderdriver: Linux module to interface Pandora arcade encoder on Pandora clone systems "
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="no"

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  unset LDFLAGS
}

make_target() {
# Ignore serio duplicate function reference. serio.ko built locally in this package will not be included in project assembly.
  kernel_make TARGET_ARCH=$TARGET_KERNEL_ARCH \
       TARGET_CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       -C "$(kernel_path)" M="$PKG_BUILD"

  make GCCBIN=$CC \
       inputattach
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
# This copies all .ko files found in build dir. Not ideal since repo includes serio which is not necessary here,
#    find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;
    cp -P pandoraclone.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME


  mkdir -p $INSTALL/usr/sbin
    cp -P inputattach-pandora $INSTALL/usr/sbin

  mkdir -p $INSTALL/usr/lib/pandoraclone
    cp $PKG_DIR/scripts/* $INSTALL/usr/lib/pandoraclone/
}

post_install() {
  enable_service pandoraclone.service
}
