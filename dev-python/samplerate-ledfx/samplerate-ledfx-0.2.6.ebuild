# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

PYBIND11_PV="3.0.1"
LIBSAMPLERATE_PV="0.2.2"

DESCRIPTION="Monolithic python wrapper for libsamplerate (LedFx fork)"
HOMEPAGE="https://github.com/LedFx/samplerate https://pypi.org/project/samplerate-ledfx/"
SRC_URI="
	$(pypi_sdist_url)
	https://github.com/pybind/pybind11/archive/refs/tags/v${PYBIND11_PV}.tar.gz
		-> pybind11-${PYBIND11_PV}.tar.gz
	https://github.com/libsndfile/libsamplerate/archive/refs/tags/${LIBSAMPLERATE_PV}.tar.gz
		-> libsamplerate-${LIBSAMPLERATE_PV}.tar.gz
"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

python_compile() {
	local -x CMAKE_ARGS="-DFETCHCONTENT_SOURCE_DIR_PYBIND11=${WORKDIR}/pybind11-${PYBIND11_PV} -DFETCHCONTENT_SOURCE_DIR_LIBSAMPLERATE=${WORKDIR}/libsamplerate-${LIBSAMPLERATE_PV}"
	distutils-r1_python_compile
}
