# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 git-r3

DESCRIPTION="Kernel module Google Coral devices"
HOMEPAGE="https://github.com/google/gasket-driver"
EGIT_REPO_URI="https://github.com/KyleGospo/gasket-dkms"
EGIT_BRANCH="main"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${S}/src"

CONFIG_CHECK="
	!STAGING_GASKET_FRAMEWORK
	!STAGING_APEX_DRIVER
"

pkg_setup() {
	linux-mod-r1_pkg_setup

	MODULES_MAKEARGS+=(
		KDIR="${KERNEL_DIR}"
	)
}

pkg_pretend() {
	check_extra_config
}

src_compile() {
	local modlist=(
		gasket
		apex
	)
	linux-mod-r1_src_compile
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
}
