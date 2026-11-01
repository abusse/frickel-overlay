# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Calculate sunrise and sunset times for a given location and day"
HOMEPAGE="https://github.com/p-mathis/suntimes https://pypi.org/project/suntimes/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	dev-python/jdcal[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest
