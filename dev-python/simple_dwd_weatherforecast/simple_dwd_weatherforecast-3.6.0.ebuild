# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A simple tool to retrieve a weather forecast from DWD OpenData"
HOMEPAGE="https://github.com/FL550/simple_dwd_weatherforecast https://pypi.org/project/simple-dwd-weatherforecast/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/arrow[${PYTHON_USEDEP}]
	=dev-python/stream-unzip-0.0.101[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest

python_install() {
    distutils-r1_python_install

    # Remove stray files
    local python_path=$(python_get_sitedir)
    if [[ -d "${D}/${python_path}/tests" ]]; then
        rm -rf "${D}/${python_path}/tests" || die "Failed to remove stray tests directory"
    fi
}

