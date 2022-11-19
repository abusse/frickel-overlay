# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 python3_10 )

inherit distutils-r1

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/mjg59/python-broadlink.git"
	inherit git-r3
else
	SRC_URI="https://github.com/mjg59/python-broadlink/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi

DESCRIPTION="Python control library for Broadlink RM2 IR controllers"
HOMEPAGE="https://github.com/mjg59/python-broadlink"

SLOT="0"
LICENSE="MIT"
IUSE=""

DEPEND="dev-python/pyaes[${PYTHON_USEDEP}]"
