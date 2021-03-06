#!/usr/bin/env bash
check_option () {
  echo 0
}
export MINGW_PREFIX="/Library/mingw-w64"
if [[ ${ARCH} == 32 ]]; then
  export CARCH=i686
else
  export CARCH=x86_64
fi
export MINGW_CHOST=$(gcc -dumpmachine)
export srcdir=${SRC_DIR}
export MAKEFLAGS=-j${CPU_COUNT}
export PKG_CONFIG_PATH=/mingw-w64/lib/pkgconfig:/mingw-w64/share/pkgconfig
export pkgdir="${PREFIX}"
export pkgver=${PKG_VERSION}
. ./PKGBUILD
# Breaks, PKG_CONFIG issues leading to CPPUNIT issues.
pushd ${srcdir}/Quantlib-${PKG_VERSION}
  ./autogen.sh
popd
build || exit 1
package || exit 1
