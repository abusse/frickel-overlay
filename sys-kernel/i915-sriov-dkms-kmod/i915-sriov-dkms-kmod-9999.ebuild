# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 git-r3

DESCRIPTION="i915/xe driver with SR-IOV support for Intel iGPUs"
HOMEPAGE="https://github.com/strongtz/i915-sriov-dkms"
EGIT_REPO_URI="https://github.com/strongtz/i915-sriov-dkms"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gvt"

# !DRM_I915 / !DRM_XE: in-tree drivers must be off, ours replace them.
# HMM_MIRROR/MMU_NOTIFIER/ZONE_DEVICE: required by the bundled DRM_GPUSVM.
# DRM_TTM/DRM_BUDDY/DRM_KMS_HELPER: needed by i915/xe gem stack.
# REGMAP_I2C: needed by xe_i2c.c.
# PCI_IOV: the whole point of this module.
# KVM_EXTERNAL_WRITE_TRACKING: only needed when building kvmgt (USE=gvt).
CONFIG_CHECK="
	DRM
	PCI_IOV
	HMM_MIRROR
	MMU_NOTIFIER
	DRM_TTM
	DRM_BUDDY
	DRM_KMS_HELPER
	ZONE_DEVICE
	REGMAP_I2C
	VMAP_PFN
	DRM_MIPI_DSI
"

pkg_setup() {
	use gvt && CONFIG_CHECK+=" KVM_EXTERNAL_WRITE_TRACKING"
	linux-mod-r1_pkg_setup
}

src_prepare() {
	default
	if ! use gvt; then
		# kvmgt implements GVT-g mediated passthrough, which is independent
		# of SR-IOV. Drop it from the kbuild so we do not pull in
		# CONFIG_KVM_EXTERNAL_WRITE_TRACKING (selectable only via
		# the in-tree DRM_I915_GVT_KVMGT, which users may not want).
		sed -i -e '/obj-m[[:space:]]*+=[[:space:]]*kvmgt\.o/d' \
			drivers/gpu/drm/i915/Makefile || die
	fi
}

src_compile() {
	# Upstream ships a top-level kbuild fragment (obj-m += compat/ ...)
	# that must be invoked via the kernel build system with M=${S}.
	# All entries share the same source-dir + target, so the eclass
	# deduplicates them into a single emake call that builds them all.
	local modargs=( -C "${KV_OUT_DIR}" M="${S}" )
	local modlist=(
		intel_sriov_compat=:.:compat:modules
		i915=:.:drivers/gpu/drm/i915:modules
		xe=:.:drivers/gpu/drm/xe:modules
	)
	if use gvt; then
		modargs+=( CONFIG_DRM_I915_GVT=y )
		modlist+=( kvmgt=:.:drivers/gpu/drm/i915:modules )
	fi
	linux-mod-r1_src_compile
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	elog "To enable SR-IOV virtual functions, set the desired numvfs via"
	elog "/sys/class/drm/card*/device/sriov_numvfs after loading i915."
}
