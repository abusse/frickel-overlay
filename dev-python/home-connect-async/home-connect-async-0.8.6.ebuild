# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Async SDK for BSH Home Connect API"
HOMEPAGE="https://github.com/ekutner/home-connect-async https://pypi.org/project/home-connect-async/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-sse-client-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/oauth2-client-1.2.1[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest
