# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="Simple Python 3 library to download, parse and query iCal sources"
HOMEPAGE="https://github.com/jazzband/icalevents https://pypi.org/project/icalevents/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/icalendar-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.9[${PYTHON_USEDEP}]
	>=dev-python/pytz-2024.2[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26.5[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest
