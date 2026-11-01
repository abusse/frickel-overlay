# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

DESCRIPTION="Open Sound Control server and client implementations in pure Python"
HOMEPAGE="https://github.com/attwad/python-osc https://pypi.org/project/python-osc/"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64"
