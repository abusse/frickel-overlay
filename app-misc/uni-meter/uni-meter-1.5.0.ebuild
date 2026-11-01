EAPI=8

DESCRIPTION="Universal electric meter converter (emulator)"
HOMEPAGE="https://github.com/sdeigm/uni-meter"
SRC_URI="https://github.com/sdeigm/uni-meter/releases/download/${PV}/uni-meter-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="test"

RDEPEND="
	virtual/jre:17
	net-dns/avahi
	acct-user/uni-meter
	acct-group/uni-meter
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/uni-meter-${PV}"

src_install() {
	insinto /opt/uni-meter
	doins -r lib config

	exeinto /opt/uni-meter/bin
	doexe bin/uni-meter.sh
	doexe bin/uni-meter-and-daemons.sh

	insinto /etc
	newins "${FILESDIR}"/uni-meter.conf uni-meter.conf

	insinto /etc/uni-meter
	doins "${FILESDIR}"/logback.xml

	newconfd "${FILESDIR}"/uni-meter.confd uni-meter
	newinitd "${FILESDIR}"/uni-meter.initd uni-meter

	exeinto /usr/libexec
	newexe "${FILESDIR}"/uni-meter-run uni-meter-run

	keepdir /var/log/uni-meter
	fowners uni-meter:uni-meter /var/log/uni-meter
	fperms 0750 /var/log/uni-meter

	keepdir /var/lib/uni-meter
	fowners uni-meter:uni-meter /var/lib/uni-meter
	fperms 0750 /var/lib/uni-meter
}

pkg_postinst() {
	elog "Configuration file: /etc/uni-meter.conf"
	elog "Logback file: /etc/uni-meter/logback.xml"
	elog "Enable service with: rc-update add uni-meter default"
}
