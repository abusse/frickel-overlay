# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_14 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python client for the Daikin Onecta cloud API"
HOMEPAGE="https://github.com/jwillemsen/daikin-onecta https://pypi.org/project/daikin-onecta/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.17.0[${PYTHON_USEDEP}]
"
