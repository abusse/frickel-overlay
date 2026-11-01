# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Python library to interact with MikroTik SwitchOS"
HOMEPAGE="https://github.com/probert94/python-switchos https://pypi.org/project/python-switchos/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/demjson3-3.0.5[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest


