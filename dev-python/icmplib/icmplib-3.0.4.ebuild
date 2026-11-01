# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Forge ICMP packets and make your own ping and traceroute"
HOMEPAGE="https://github.com/ValentinBELYN/icmplib https://pypi.org/project/icmplib/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
