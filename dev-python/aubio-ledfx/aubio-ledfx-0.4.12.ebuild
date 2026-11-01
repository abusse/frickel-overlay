# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

DESCRIPTION="A collection of tools for music analysis (LedFx fork of aubio)"
HOMEPAGE="https://github.com/LedFx/aubio https://pypi.org/project/aubio-ledfx/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
