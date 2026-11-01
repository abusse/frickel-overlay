# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{13..14} )
inherit distutils-r1 pypi

DESCRIPTION="A network based, audio-reactive light effect controller"
HOMEPAGE="https://github.com/LedFx/LedFx https://www.ledfx.app/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="sendspin"

RDEPEND="
	acct-group/ledfx
	acct-user/ledfx
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiohttp-cors[${PYTHON_USEDEP}]
	dev-python/audio-hotplug[${PYTHON_USEDEP}]
	dev-python/aubio-ledfx[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/flux-led[${PYTHON_USEDEP}]
	dev-python/icmplib[${PYTHON_USEDEP}]
	dev-python/lifx-async[${PYTHON_USEDEP}]
	dev-python/mss[${PYTHON_USEDEP}]
	dev-python/multidict[${PYTHON_USEDEP}]
	dev-python/netifaces2[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/openrgb-python[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/paho-mqtt[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pybase64[${PYTHON_USEDEP}]
	dev-python/pyfastnoiselite[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/python-osc[${PYTHON_USEDEP}]
	dev-python/python-rtmidi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/sacn[${PYTHON_USEDEP}]
	dev-python/samplerate-ledfx[${PYTHON_USEDEP}]
	dev-python/sentry-sdk[${PYTHON_USEDEP}]
	dev-python/sounddevice[${PYTHON_USEDEP}]
	dev-python/stupidartnet[${PYTHON_USEDEP}]
	dev-python/uvloop[${PYTHON_USEDEP}]
	dev-python/voluptuous[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/xled[${PYTHON_USEDEP}]
	dev-python/zeroconf[${PYTHON_USEDEP}]
	sendspin? (
		$(python_gen_cond_dep '
			dev-python/aiosendspin[${PYTHON_USEDEP}]
			dev-python/pyflac[${PYTHON_USEDEP}]
		' python3_{12,13})
	)
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

DOCS=( README.rst CHANGELOG.rst AUTHORS.rst )

python_install() {
	distutils-r1_python_install
	# pdm-backend installs these project files at the top of site-packages,
	# which Gentoo QA rejects. Docs are installed via DOCS/dodoc instead, and
	# ledfx.env only carries optional release metadata (IS_RELEASE etc).
	local sitedir="${D}$(python_get_sitedir)"
	rm "${sitedir}"/{LICENSE.txt,CHANGELOG.rst,AUTHORS.rst,README.rst,ledfx.env} || die
}

src_install() {
	distutils-r1_src_install
	newinitd "${FILESDIR}"/ledfx.initd ledfx
	newconfd "${FILESDIR}"/ledfx.confd ledfx
}

pkg_postinst() {
	elog "LedFx has been installed."
	elog
	elog "To run it as a system service:"
	elog "  rc-update add ledfx default"
	elog "  rc-service ledfx start"
	elog
	elog "Configuration (port, host, options) lives in /etc/conf.d/ledfx."
	elog "Runtime config and presets are stored in /var/lib/ledfx."
	elog "The web interface defaults to http://<host>:8888"
	elog
	elog "The ledfx user is a member of the 'audio' group for local audio"
	elog "capture (PortAudio). For network/visualisation-only use this is"
	elog "not required."
	if use sendspin; then
		elog
		elog "Sendspin multi-room audio support is enabled (Python 3.12+)."
	fi
}
