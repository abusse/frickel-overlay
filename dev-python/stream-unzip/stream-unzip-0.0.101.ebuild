# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin

CRATES="
	crc32-v2@0.0.4
	heck@0.5.0
	libc@0.2.159
	once_cell@1.21.3
	portable-atomic@1.9.0
	proc-macro2@1.0.87
	pyo3-build-config@0.28.2
	pyo3-ffi@0.28.2
	pyo3-macros-backend@0.28.2
	pyo3-macros@0.28.2
	pyo3@0.28.2
	quote@1.0.37
	syn@2.0.79
	target-lexicon@0.13.5
	unicode-ident@1.0.13
"

inherit cargo distutils-r1 pypi

DESCRIPTION="A streaming unzip library"
HOMEPAGE="https://github.com/uktrade/stream-unzip https://pypi.org/project/stream-unzip/"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
# crates
LICENSE+=" Apache-2.0 MIT Unicode-3.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/pycryptodome-3.10.1[${PYTHON_USEDEP}]
	>=dev-python/stream-inflate-0.0.12[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
