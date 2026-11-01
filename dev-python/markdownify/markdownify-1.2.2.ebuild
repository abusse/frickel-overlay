# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Convert HTML to markdown"
HOMEPAGE="https://github.com/matthewwithanm/python-markdownify https://pypi.org/project/markdownify/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/beautifulsoup4-4.9[${PYTHON_USEDEP}]
	>=dev-python/six-1.15[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest

src_prepare() {
    default

    # Exclude tests from install
#    sed -i '/find_packages()/ s|find_packages()|find_packages(exclude=["tests", "tests.*"])|' setup.py || die
}
