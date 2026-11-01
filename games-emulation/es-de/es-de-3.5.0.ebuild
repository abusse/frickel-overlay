# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_P="emulationstation-de-v${PV}"

DESCRIPTION="ES-DE (EmulationStation Desktop Edition) game frontend"
HOMEPAGE="https://es-de.org https://gitlab.com/es-de/emulationstation-de"
SRC_URI="https://gitlab.com/es-de/emulationstation-de/-/archive/v${PV}/${MY_P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# deinit-on-launch: release renderer/window/audio while an emulator runs
# (required when running on KMS/DRM without a display server)
IUSE="+deinit-on-launch gles video-hw-decoding"

RDEPEND="
	app-text/poppler[cxx]
	dev-libs/icu:=
	dev-libs/libgit2:=
	dev-libs/pugixml
	media-libs/alsa-lib
	media-libs/freeimage
	media-libs/freetype
	media-libs/harfbuzz:=
	media-libs/libsdl2[joystick,sound,video]
	media-video/ffmpeg:=
	net-misc/curl
	net-wireless/bluez
	gles? ( media-libs/libglvnd )
	!gles? ( virtual/opengl )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DAPPLICATION_UPDATER=OFF
		-DBUNDLED_CERTS=OFF
		-DGL=$(usex gles OFF ON)
		-DGLES=$(usex gles)
		-DDEINIT_ON_LAUNCH=$(usex deinit-on-launch)
		-DVIDEO_HW_DECODING=$(usex video-hw-decoding)
	)
	cmake_src_configure
}
