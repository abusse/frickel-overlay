# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="A Python library to communicate with the flux_led smart bulbs"
HOMEPAGE="https://github.com/Danielhiversen/flux_led https://pypi.org/project/flux-led/"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-python/webcolors[${PYTHON_USEDEP}]
	dev-python/async-timeout[${PYTHON_USEDEP}]
"
