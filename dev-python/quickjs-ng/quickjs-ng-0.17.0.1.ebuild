# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

QJS_PV=$(ver_cut 1-3)

DESCRIPTION="Thin Python wrapper of quickjs-ng"
HOMEPAGE="https://github.com/genotrance/quickjs-ng https://pypi.org/project/quickjs-ng/"
SRC_URI+="
	https://github.com/quickjs-ng/quickjs/archive/refs/tags/v${QJS_PV}.tar.gz
		-> quickjs-ng-${QJS_PV}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests pytest

src_prepare() {
	# sdist omits headers that the bundled quickjs.c includes
	local h
	for h in quickjs-c-atomics.h builtin-array-fromasync.h \
		builtin-iterator-zip.h builtin-iterator-zip-keyed.h; do
		cp "${WORKDIR}/quickjs-${QJS_PV}/${h}" upstream-quickjs/ || die
	done
	distutils-r1_src_prepare
}
