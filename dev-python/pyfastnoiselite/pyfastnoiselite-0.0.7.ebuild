# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

FASTNOISE_COMMIT="8c45924f086edcb93b8876eb351c07d5e982e47f"

DESCRIPTION="Cython wrapper for Auburns' FastNoise Lite"
HOMEPAGE="https://github.com/tizilogic/pyfastnoiselite"
SRC_URI="
	https://github.com/tizilogic/pyfastnoiselite/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/Auburn/FastNoise/archive/${FASTNOISE_COMMIT}.tar.gz
		-> FastNoise-${FASTNOISE_COMMIT}.tar.gz
"

LICENSE="MIT"
S="${WORKDIR}/PyFastNoiseLite-${PV}"

SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
"

src_prepare() {
	# Provide the FastNoise git submodule content that GitHub archives omit,
	# so setup.py does not try to download it at build time.
	rmdir ext/FastNoise 2>/dev/null
	cp -r "${WORKDIR}/FastNoiseLite-${FASTNOISE_COMMIT}"/. ext/FastNoise/ || die
	distutils-r1_src_prepare
}
