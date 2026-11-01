# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..14} )

CRATES="
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.4.2
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	indoc@1.0.7
	libc@0.2.153
	lock_api@0.4.9
	log@0.4.20
	memoffset@0.6.5
	memoffset@0.9.0
	nix@0.28.0
	once_cell@1.15.0
	parking_lot@0.12.1
	parking_lot_core@0.9.3
	proc-macro2@1.0.70
	pyo3@0.17.2
	pyo3-build-config@0.17.2
	pyo3-ffi@0.17.2
	pyo3-macros@0.17.2
	pyo3-macros-backend@0.17.2
	quote@1.0.33
	redox_syscall@0.2.16
	scopeguard@1.1.0
	smallvec@1.10.0
	syn@1.0.102
	syn@2.0.41
	target-lexicon@0.12.4
	thiserror@1.0.51
	thiserror-impl@1.0.51
	unicode-ident@1.0.5
	unindent@0.1.10
	windows@0.42.0
	windows-sys@0.36.1
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_msvc@0.36.1
	windows_aarch64_msvc@0.42.0
	windows_i686_gnu@0.36.1
	windows_i686_gnu@0.42.0
	windows_i686_msvc@0.36.1
	windows_i686_msvc@0.42.0
	windows_x86_64_gnu@0.36.1
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_msvc@0.36.1
	windows_x86_64_msvc@0.42.0
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Portable network interface information (maintained netifaces replacement)"
HOMEPAGE="https://github.com/SamuelYvon/netifaces-2 https://pypi.org/project/netifaces2/"
SRC_URI="
	$(pypi_sdist_url)
	https://static.crates.io/crates/autocfg/autocfg-1.1.0.crate
	https://static.crates.io/crates/bitflags/bitflags-1.3.2.crate
	https://static.crates.io/crates/bitflags/bitflags-2.4.2.crate
	https://static.crates.io/crates/cfg-if/cfg-if-1.0.0.crate
	https://static.crates.io/crates/cfg_aliases/cfg_aliases-0.1.1.crate
	https://static.crates.io/crates/indoc/indoc-1.0.7.crate
	https://static.crates.io/crates/libc/libc-0.2.153.crate
	https://static.crates.io/crates/lock_api/lock_api-0.4.9.crate
	https://static.crates.io/crates/log/log-0.4.20.crate
	https://static.crates.io/crates/memoffset/memoffset-0.6.5.crate
	https://static.crates.io/crates/memoffset/memoffset-0.9.0.crate
	https://static.crates.io/crates/nix/nix-0.28.0.crate
	https://static.crates.io/crates/once_cell/once_cell-1.15.0.crate
	https://static.crates.io/crates/parking_lot/parking_lot-0.12.1.crate
	https://static.crates.io/crates/parking_lot_core/parking_lot_core-0.9.3.crate
	https://static.crates.io/crates/proc-macro2/proc-macro2-1.0.70.crate
	https://static.crates.io/crates/pyo3/pyo3-0.17.2.crate
	https://static.crates.io/crates/pyo3-build-config/pyo3-build-config-0.17.2.crate
	https://static.crates.io/crates/pyo3-ffi/pyo3-ffi-0.17.2.crate
	https://static.crates.io/crates/pyo3-macros/pyo3-macros-0.17.2.crate
	https://static.crates.io/crates/pyo3-macros-backend/pyo3-macros-backend-0.17.2.crate
	https://static.crates.io/crates/quote/quote-1.0.33.crate
	https://static.crates.io/crates/redox_syscall/redox_syscall-0.2.16.crate
	https://static.crates.io/crates/scopeguard/scopeguard-1.1.0.crate
	https://static.crates.io/crates/smallvec/smallvec-1.10.0.crate
	https://static.crates.io/crates/syn/syn-1.0.102.crate
	https://static.crates.io/crates/syn/syn-2.0.41.crate
	https://static.crates.io/crates/target-lexicon/target-lexicon-0.12.4.crate
	https://static.crates.io/crates/thiserror/thiserror-1.0.51.crate
	https://static.crates.io/crates/thiserror-impl/thiserror-impl-1.0.51.crate
	https://static.crates.io/crates/unicode-ident/unicode-ident-1.0.5.crate
	https://static.crates.io/crates/unindent/unindent-0.1.10.crate
	https://static.crates.io/crates/windows/windows-0.42.0.crate
	https://static.crates.io/crates/windows-sys/windows-sys-0.36.1.crate
	https://static.crates.io/crates/windows_aarch64_gnullvm/windows_aarch64_gnullvm-0.42.0.crate
	https://static.crates.io/crates/windows_aarch64_msvc/windows_aarch64_msvc-0.36.1.crate
	https://static.crates.io/crates/windows_aarch64_msvc/windows_aarch64_msvc-0.42.0.crate
	https://static.crates.io/crates/windows_i686_gnu/windows_i686_gnu-0.36.1.crate
	https://static.crates.io/crates/windows_i686_gnu/windows_i686_gnu-0.42.0.crate
	https://static.crates.io/crates/windows_i686_msvc/windows_i686_msvc-0.36.1.crate
	https://static.crates.io/crates/windows_i686_msvc/windows_i686_msvc-0.42.0.crate
	https://static.crates.io/crates/windows_x86_64_gnu/windows_x86_64_gnu-0.36.1.crate
	https://static.crates.io/crates/windows_x86_64_gnu/windows_x86_64_gnu-0.42.0.crate
	https://static.crates.io/crates/windows_x86_64_gnullvm/windows_x86_64_gnullvm-0.42.0.crate
	https://static.crates.io/crates/windows_x86_64_msvc/windows_x86_64_msvc-0.36.1.crate
	https://static.crates.io/crates/windows_x86_64_msvc/windows_x86_64_msvc-0.42.0.crate
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" || ( MIT Apache-2.0 ) Apache-2.0 BSD MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="amd64"

QA_FLAGS_IGNORED=".*/netifaces.*.so"
