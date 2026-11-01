# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Python client for Sentry"
HOMEPAGE="https://github.com/getsentry/sentry-python https://pypi.org/project/sentry-sdk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
"
