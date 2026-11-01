# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1

MY_PN="pdfminer_six"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PDF parser and analyzer"
HOMEPAGE="
	https://pypi.org/project/pdfminer.six/
	https://github.com/pdfminer/pdfminer.six
"
SRC_URI="https://files.pythonhosted.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="image"
RESTRICT="test"

RDEPEND="
	>=dev-python/charset-normalizer-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-36.0.0[${PYTHON_USEDEP}]
	image? ( dev-python/pillow[${PYTHON_USEDEP}] )
"

BDEPEND=""

