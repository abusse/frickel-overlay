# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_PN="pyFLAC"
inherit distutils-r1 pypi

DESCRIPTION="A Python wrapper for libFLAC (bundles libFLAC)"
HOMEPAGE="https://github.com/sonos/pyFLAC https://pypi.org/project/pyFLAC/"
SRC_URI="$(pypi_sdist_url --no-normalize)"
S="${WORKDIR}/${PYPI_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

# pyFLAC ships a prebuilt libFLAC shared library loaded via an $ORIGIN rpath.
QA_PREBUILT="usr/lib*/python*/site-packages/pyflac/libraries/*"

RDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/soundfile[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/cffi[${PYTHON_USEDEP}]"
