# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Python control library for Broadlink RM2 IR controllers"
HOMEPAGE="https://github.com/mjg59/python-broadlink"
EGIT_REPO_URI="https://github.com/mjg59/python-broadlink.git"

SLOT="0"
LICENSE="MIT"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/pyaes[${PYTHON_USEDEP}]"
