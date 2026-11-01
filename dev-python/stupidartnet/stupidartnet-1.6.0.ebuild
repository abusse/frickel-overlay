# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

DESCRIPTION="(Very) Simple implementation of the Art-Net protocol"
HOMEPAGE="https://github.com/cpvalente/stupidArtnet https://pypi.org/project/stupidartnet/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
