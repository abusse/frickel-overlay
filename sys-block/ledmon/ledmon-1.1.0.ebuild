# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Enclosure LED utilities (ledmon, ledctl) for AHCI/SAS/SES backplanes"
HOMEPAGE="https://github.com/md-raid-utilities/ledmon"
SRC_URI="https://github.com/md-raid-utilities/ledmon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-apps/pciutils
	sys-apps/sg3_utils
	virtual/libudev
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/pkgconf
	dev-build/autoconf-archive
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-systemd \
		--disable-doc
}
