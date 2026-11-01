# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="A python client for the OpenRGB SDK"
HOMEPAGE="https://github.com/jath03/openrgb-python https://pypi.org/project/openrgb-python/"
SRC_URI="$(pypi_sdist_url --no-normalize)"
S="${WORKDIR}/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
