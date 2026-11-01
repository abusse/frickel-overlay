# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

# must match __version__ in scripts/build.py
IMPERSONATE_PV=1.5.2
IMPERSONATE_TARBALL="libcurl-impersonate-v${IMPERSONATE_PV}.x86_64-linux-gnu.tar.gz"

DESCRIPTION="Python binding for curl-impersonate fork via cffi"
HOMEPAGE="
	https://pypi.org/project/curl-cffi/
	https://github.com/lexiforest/curl_cffi
"
SRC_URI+="
	https://github.com/lexiforest/curl-impersonate/releases/download/v${IMPERSONATE_PV}/${IMPERSONATE_TARBALL}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="test"

RDEPEND="
	>=dev-python/cffi-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2024.2.2[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/cffi-2.0.0[${PYTHON_USEDEP}]
"

src_unpack() {
	unpack "${P}.tar.gz"
	# prebuilt static libcurl-impersonate; scripts/build.py would otherwise
	# download it at build time (blocked by network-sandbox)
	mkdir "${WORKDIR}/libcurl-impersonate" || die
	tar -C "${WORKDIR}/libcurl-impersonate" -xzf "${DISTDIR}/${IMPERSONATE_TARBALL}" || die
}

python_prepare() {
	"${EPYTHON}" - "${WORKDIR}/libcurl-impersonate" <<-EOF || die
		import json, sys
		archs = json.load(open("libs.json"))
		for a in archs: a["libdir"] = sys.argv[1]
		json.dump(archs, open("libs.json", "w"), indent=4)
	EOF
}

python_test() {
	die "Upstream tests are not wired for Gentoo here"
}
