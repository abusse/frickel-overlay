# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A client library for OAuth2"
HOMEPAGE="https://github.com/antechrestos/OAuth2Client https://pypi.org/project/oauth2-client/"

SRC_URI="$(pypi_sdist_url --no-normalize oauth2-client ${PV}) -> ${P}.tar.gz"
S="${WORKDIR}/oauth2-client-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE=""

RDEPEND=""
BDEPEND=""
