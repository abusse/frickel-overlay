# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

DESCRIPTION="Cross-platform audio device hotplug detection with debouncing"
HOMEPAGE="https://pypi.org/project/audio-hotplug/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-python/pyudev[${PYTHON_USEDEP}]
"
