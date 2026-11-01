# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

SRC_URI="$(pypi_sdist_url --no-normalize aiohttp-sse-client ${PV}) -> ${P}.tar.gz"
S="${WORKDIR}/aiohttp-sse-client-${PV}"

DESCRIPTION="A Server-Sent Event python client based on aiohttp"
HOMEPAGE="https://github.com/rtfol/aiohttp-sse-client https://pypi.org/project/aiohttp-sse-client/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/aiohttp-3[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/multidict[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest
