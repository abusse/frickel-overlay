# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Converts PIC plots into pstricks, PGF/TikZ, PostScript, MetaPost and TeX"
HOMEPAGE="http://ece.uwaterloo.ca/~aplevich/dpic"
SRC_URI="https://ece.uwaterloo.ca/~aplevich/dpic/${PN}-2016.01.12.tar.gz"

LICENSE="BSD-2 CC-BY-3.0 GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-2016.01.12"

src_compile () {
	emake CC="$(tc-getCC)"
}

src_install () {
	dobin dpic
	doman doc/dpic.1
	dodoc README doc/dpicdoc.pdf doc/gpic.pdf
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
