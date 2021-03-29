# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/facchinm/${PN}.git"

inherit autotools git-r3

DESCRIPTION="AVR Downloader/UploaDEr, UPDI Improved Github"
HOMEPAGE="https://savannah.nongnu.org/projects/avrdude"
MY_DOC_PV=6.3
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc ftdi ncurses readline"

RDEPEND="virtual/libusb:1
	virtual/libusb:0
	ftdi? ( dev-embedded/libftdi:= )
	ncurses? ( sys-libs/ncurses:0= )
	readline? ( sys-libs/readline:0= )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog* NEWS README"

src_prepare() {
	default

	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h || die

	eautoreconf
}

src_configure() {
	# somehow this doesnt get set when cross-compiling and breaks build
	tc-export AR
	export ac_cv_lib_ftdi_ftdi_usb_get_strings=$(usex ftdi)
	export ac_cv_lib_ncurses_tputs=$(usex ncurses)
	export ac_cv_lib_readline_readline=$(usex readline)
	econf --disable-static
}

src_compile() {
	# The automake target for these files does not use tempfiles or create
	# these atomically, confusing a parallel build. So we force them first.
	emake lexer.c config_gram.c config_gram.h
	emake
}

src_install() {
	default

	if use doc ; then
		newdoc "${DISTDIR}/${PN}-doc-${MY_DOC_PV}.pdf" avrdude.pdf
		dodoc -r "${WORKDIR}/avrdude-html/"

		dodoc -r atmel-docs
	fi

	find "${ED}" -name '*.la' -delete || die
}
