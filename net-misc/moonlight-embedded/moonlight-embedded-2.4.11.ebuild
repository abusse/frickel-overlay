# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/irtimmer/moonlight-embedded.git"
EGIT_COMMIT="v${PV}"

inherit cmake git-r3

DESCRIPTION="Moonlight Embedded is an open source implementation of NVIDIA's GameStream"
HOMEPAGE="https://github.com/irtimmer/moonlight-embedded"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/expat
	dev-libs/libevdev
	dev-libs/openssl
	media-libs/alsa-lib
	media-libs/opus
	net-dns/avahi
	net-libs/enet:*"
RDEPEND="${DEPEND}
	!!net-misc/moonlight-qt
	!!net-libs/libgamestream"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_VERBOSE_MAKEFILE=ON
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_INSTALL_SYSCONFDIR=/etc
		-DCMAKE_INSTALL_LOCALSTATEDIR=/var
	)
	cmake_src_configure
}
