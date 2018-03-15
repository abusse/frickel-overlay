# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit user python-single-r1 git-r3

EGIT_REPO_URI="https://github.com/eschava/${PN}.git"

DESCRIPTION="MQTT client to control BroadLink devices"
HOMEPAGE="https://github.com/eschava/broadlink-mqtt"

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="dev-python/paho-mqtt[${PYTHON_USEDEP}]
		 dev-python/broadlink-python[${PYTHON_USEDEP}]
		 ${DEPEND}"

PATCHES=(
	"${FILESDIR}"/remove-test-device.patch
	"${FILESDIR}"/fix-config-path.patch
)

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
