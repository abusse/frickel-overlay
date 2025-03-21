# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic git-r3

EGIT_REPO_URI="https://github.com/catalinii/${PN}.git"
EGIT_COMMIT="v${PV}"

DESCRIPTION="minisatip, a SAT>IP server using local DVB-S2, DVB-C, DVB-T or ATSC cards"
HOMEPAGE="https://minisatip.org/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="dvbcsa"

DEPEND="media-libs/libdvbcsa"
# libdvbcsa default installed without use-flag handling,
# as it fails on compile without it, need fixing by upstream

#S="${WORKDIR}/minisatip-${GIT_VERSION}"

pkg_setup() {
	append-flags -lpthread -fPIC -lrt
}

src_configure() {
	local config_dvbcsa=""
	! use  dvbcsa && config_dvbcsa="--disable-dvbcsa"

	econf \
		--prefix=/usr/bin \
		${config_dvbcsa} \
		|| die "configure failed"
}

src_install() {
	dobin minisatip

	newinitd "${FILESDIR}"/minisatip.init minisatip
	newconfd "${FILESDIR}"/minisatip.conf minisatip
}
