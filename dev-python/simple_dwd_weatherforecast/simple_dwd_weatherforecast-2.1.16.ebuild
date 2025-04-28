# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="TODO"
HOMEPAGE="https://github.com/FL550/simple_dwd_weatherforecast https://pypi.org/project/imple-dwd-weatherforecast/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
BDEPEND=""

distutils_enable_tests pytest

python_install() {
    distutils-r1_python_install

    # Remove stray files
    local python_path=$(python_get_sitedir)
    echo "DEBUG: Python site-packages path: ${python_path}"
    if [[ -d "${D}/${python_path}/tests" ]]; then
        rm -rf "${D}/${python_path}/tests" || die "Failed to remove stray tests directory"
    fi
}

