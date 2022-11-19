# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..10} )

inherit user git-r3

EGIT_REPO_URI="https://github.com/eschava/${PN}.git"

DESCRIPTION="MQTT client to control BroadLink devices"
HOMEPAGE="https://github.com/eschava/broadlink-mqtt"

KEYWORDS="amd64 x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/paho-mqtt
	dev-python/python-broadlink"

pkg_setup() {
	enewgroup broadlink-mqtt
	enewuser broadlink-mqtt -1 -1 -1 broadlink-mqtt
	python-single-r1_pkg_setup
}

src_install() {
	python_fix_shebang mqtt.py
	newbin mqtt.py ${PN}.py
	keepdir /var/lib/broadlink-mqtt
	fowners broadlink-mqtt:broadlink-mqtt /var/lib/broadlink-mqtt
	insinto /var/lib/broadlink-mqtt
	doins logging.conf
	dodoc README.md
	doinitd "${FILESDIR}"/broadlink-mqtt
	insinto /etc
	newins mqtt.conf broadlink-mqtt.conf
	newins custom.conf broadlink-mqtt-custom.conf
}
