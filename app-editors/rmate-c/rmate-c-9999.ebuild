# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-any-r1 toolchain-funcs

DESCRIPTION="Remote TextMate/Sublime - Edit files from anywhere in TextMate/Sublime.(C Impl.)"
HOMEPAGE="https://github.com/abusse/rmate.c"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/abusse/rmate.c.git"
else
	COMMIT="df25bca9369afb68453328931da56d3b5b3dc990"
	SRC_URI="https://github.com/abusse/rmate.c/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/rmate.c-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="!app-editors/rmate"
BDEPEND="test? ( ${PYTHON_DEPS} )"

DOCS=( README.md PROTOCOL.md )

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_compile() {
	local args=( CC="$(tc-getCC)" )
	# the Makefile asks git for a build id, a snapshot has none
	[[ ${PV} == 9999 ]] || args+=( BUILD_ID= )
	emake "${args[@]}"
}

src_test() {
	emake check PYTHON="${EPYTHON}"
}

src_install() {
	dobin rmate
	einstalldocs
}
