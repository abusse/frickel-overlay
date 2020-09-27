# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/moonlight-stream/moonlight-qt.git"
EGIT_COMMIT="v${PV}"

KEYWORDS="~amd64"

inherit git-r3 qmake-utils

DESCRIPTION="Moonlight PC is an open source implementation of NVIDIA's GameStream"
HOMEPAGE="https://github.com/moonlight-stream/moonlight-qt"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols2
	dev-qt/qtsvg
	media-libs/libsdl2
	media-libs/opus
	media-libs/sdl2-ttf
"
BDEPEND="${RDEPEND}"

src_configure() {
	eqmake5 ${PN}.pro
}

#src_install() {
#        emake install INSTALL_ROOT="${D}"
#}
