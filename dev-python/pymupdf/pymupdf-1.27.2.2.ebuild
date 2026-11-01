# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A high performance Python library for data extraction, analysis, conversion and manipulation of PDF documents"
HOMEPAGE="https://github.com/pymupdf/pymupdf https://pypi.org/project/PyMuPDF/"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
BDEPEND=""

src_prepare() {
	default
	sed -i 's|setup|setuptools.build_meta|g' pyproject.toml || die
}

distutils_enable_tests pytest
