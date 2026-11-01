# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/abusse/rmate.c.git"

inherit git-r3

DESCRIPTION="Remote TextMate/Sublime - Edit files from anywhere in TextMate/Sublime.(C Impl.)"
HOMEPAGE="https://github.com/abusse/rmate.c"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		!app-editors/rmate"
