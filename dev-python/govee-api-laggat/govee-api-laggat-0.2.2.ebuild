# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Implementation of the Govee API to control LED strips and bulbs"
HOMEPAGE="https://github.com/LaggAt/python-govee-api https://pypi.org/project/govee-api-laggat/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/aiohttp-3.7.1[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/events[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest

python_install() {
    distutils-r1_python_install

    local sitedir
    sitedir="$(python_get_sitedir)"

    if [[ -d "${D}${sitedir}/tests" ]]; then
        rm -r "${D}${sitedir}/tests" || die "Failed to remove stray tests dir"
    fi
}

