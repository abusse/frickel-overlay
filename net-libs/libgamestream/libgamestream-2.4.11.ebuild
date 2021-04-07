# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/irtimmer/moonlight-embedded.git"
EGIT_COMMIT="v${PV}"

CMAKE_USE_DIR="${S}/libgamestream"

inherit cmake git-r3

DESCRIPTION="Moonlight libraries to interact with NVIDIA's GameStream"
HOMEPAGE="https://github.com/irtimmer/moonlight-embedded"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/expat
	dev-libs/libevdev
	dev-libs/openssl
	net-dns/avahi
	net-libs/enet:*"
RDEPEND="${DEPEND}
	!!net-misc/moonlight-embedded"

src_prepare() {
	sed -i '1s/^/SET(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}\/..\/cmake")\n/' "${CMAKE_USE_DIR}/CMakeLists.txt"
	sed -i '1s/^/project(libgamestream VERSION 2.4.11 LANGUAGES C)\n/' "${CMAKE_USE_DIR}/CMakeLists.txt"
	sed -i '1s/^/cmake_minimum_required(VERSION 3.1)\n/' "${CMAKE_USE_DIR}/CMakeLists.txt"

	cmake_src_prepare
}
