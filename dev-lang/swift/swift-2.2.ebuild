# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7  )

inherit autotools python-single-r1

DESCRIPTION="The Swift programming language and debugger"
HOMEPAGE="http://swift.org/"
_swiftver="2.2-SNAPSHOT-2016-02-08-a"
_swiftold="2.2-SNAPSHOT-2016-01-11-a"
SRC_URI="https://github.com/apple/swift/archive/swift-${_swiftver}.tar.gz -> swift-${_swiftver}.tar.gz
		https://github.com/apple/swift-llvm/archive/swift-${_swiftver}.tar.gz -> swift-llvm-${_swiftver}.tar.gz
		https://github.com/apple/swift-clang/archive/swift-${_swiftver}.tar.gz -> swift-clang-${_swiftver}.tar.gz
		lldb? ( https://github.com/apple/swift-lldb/archive/swift-${_swiftver}.tar.gz -> swift-lldb-${_swiftver}.tar.gz )
		https://github.com/apple/swift-cmark/archive/swift-${_swiftver}.tar.gz -> swift-cmark-${_swiftver}.tar.gz
		https://github.com/apple/swift-llbuild/archive/swift-${_swiftold}.tar.gz -> swift-llbuild-${_swiftold}.tar.gz
		https://github.com/apple/swift-package-manager/archive/swift-${_swiftold}.tar.gz -> swift-package-manager-${_swiftold}.tar.gz
		https://github.com/apple/swift-corelibs-xctest/archive/swift-${_swiftold}.tar.gz -> swift-corelibs-xctest-${_swiftold}.tar.gz
		https://github.com/apple/swift-corelibs-foundation/archive/swift-${_swiftold}.tar.gz -> swift-corelibs-foundation-${_swiftold}.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="lldb"
RESTRICT="mirror"

DEPEND=">=sys-devel/clang-3.6
		dev-lang/swig
		dev-python/six
		dev-util/cmake
		dev-util/ninja
		dev-python/sphinx
"

RDEPEND="${DEPEND}
		dev-db/sqlite
		dev-lang/python
		dev-libs/icu
		dev-libs/libbsd
		dev-libs/libedit
		dev-libs/libxml2
		sys-apps/util-linux
		sys-libs/ncurses
		lldb? ( sys-devel/llvm[-lldb] )
"

S="${WORKDIR}"
CARCH=`uname -m`

src_prepare() { 
	# Use python2 where appropriate
	find "${S}" -type f -print0 | \
		 xargs -0 sed -i 's|/usr/bin/env python$|&2|'		
	sed -i '/^cmake_minimum_required/a set(Python_ADDITIONAL_VERSIONS 2.7)' \
		 "${S}/swift-swift-${_swiftver}/CMakeLists.txt"
	sed -i 's/\<python\>/&2/' \
		 "${S}/swift-swift-${_swiftver}/utils/build-script-impl"
	if use lldb; then
		find "${S}/swift-lldb-swift-${_swiftver}" -name Makefile -print0 | \
			 xargs -0 sed -i 's|python-config|python2-config|g'
		sed -i '/^cmake_minimum_required/a set(Python_ADDITIONAL_VERSIONS 2.7)' \
			 "${S}/swift-lldb-swift-${_swiftver}/CMakeLists.txt"
	fi

	# Fix bad include paths
	find "${S}" -type f -print0 | \
		 xargs -0 sed -i 's|/usr/include/x86_64-linux-gnu|/usr/include|g'

	# Use directory names which build-script expects
	for sdir in llvm clang lldb cmark llbuild corelibs-xctest corelibs-foundation; do
		if [[ "$sdir" =~ ^corelibs- ]]; then
			ln -sf swift-${sdir}-swift-${_swiftold} swift-${sdir}
		elif [[ "$sdir" == "llbuild" ]]; then
			ln -sf swift-${sdir}-swift-${_swiftold} ${sdir}
		else
			ln -sf swift-${sdir}-swift-${_swiftver} ${sdir}
		fi
	done
	ln -sf swift-swift-${_swiftver} swift
	ln -sf swift-package-manager-swift-${_swiftold} swiftpm
}

src_compile(){
	cd "${S}/swift"

	export SWIFT_SOURCE_ROOT="${S}"
	export LDFLAGS='-ldl -lpthread'
	
	# build a release version (-R) instead of debug and use #CPU to build
	BUILD_FLAGS="--release -j $(lscpu --parse=CPU | grep -v '^#' | wc -l) "
	
	# build additional componenents
	BUILD_FLAGS+="--llbuild --swiftpm --xctest --foundation "
	
	# build lldb only when requested
	if use lldb; then
		BUILD_FLAGS+="--lldb "
	fi
	
	utils/build-script ${BUILD_FLAGS}
}

src_test() {
	cd "${S}/swift"

	export SWIFT_SOURCE_ROOT="${S}"
	export LDFLAGS='-ldl -lpthread'
	
	# build a release version (-R) instead of debug and use #CPU to build
	BUILD_FLAGS="--release -j $(lscpu --parse=CPU | grep -v '^#' | wc -l) "
	
	# build additional componenents
	BUILD_FLAGS+="--llbuild --swiftpm --xctest --foundation "
	
	# build lldb only when requested
	if use lldb; then
		BUILD_FLAGS+="--lldb "
	fi

	# run only tests
	BUILD_FLAGS+="--skip-build --test "

	utils/build-script ${BUILD_FLAGS}
}

src_install() { 
################################################################################
# This does not work for now even though it should. Let's see what the future brings
################################################################################
#	cd "${S}/swift"
#
#	export SWIFT_SOURCE_ROOT="${S}"
#	export LDFLAGS='-ldl -lpthread'
#	
#	# build a release version (-R) instead of debug and use #CPU to build
#	BUILD_FLAGS="--release -j $(lscpu --parse=CPU | grep -v '^#' | wc -l) "
#	
#	# build additional componenents
#	BUILD_FLAGS+="--llbuild --swiftpm --xctest --foundation "
#	
#	# build lldb only when requested
#	if use lldb; then
#		BUILD_FLAGS+="--lldb "
#	fi
#
#	# no need to build again for install
#	BUILD_FLAGS+="--skip-build "
#
#	# set proper install prefix
#	BUILD_FLAGS+="-- --install-destdir \"${D}\" "
#
#	BUILD_FLAGS+="--install-cmark --install-swift --install-llbuild --install-swiftpm --install-xctest --install-foundation "
#	
#	# install lldb only when requested
#	if use lldb; then
#		BUILD_FLAGS+="--install-lldb "
#	fi	
#
#	utils/build-script ${BUILD_FLAGS}

    cd "${S}/build/Ninja-ReleaseAssert"

    install -dm755 "${D}/usr/bin"
    install -dm755 "${D}/usr/lib/swift"

    # Swift's components don't provide an install target :(
    # These are based on what's included in the binary release packages
    (
        cd swift-linux-$CARCH
        install -m755 bin/swift bin/swift-demangle bin/swift-compress bin/swift-ide-test "${D}/usr/bin"
        ln -s swift "${D}/usr/bin/swiftc"
        ln -s swift "${D}/usr/bin/swift-autolink-extract"

        install -dm755 "${D}/usr/share/man/man1"
        install -m644 docs/tools/swift.1 "${D}/usr/share/man/man1"

        umask 0022
        cp -rL lib/swift/{clang,glibc,linux,shims} "${D}/usr/lib/swift/"
    )
    (
        cd llbuild-linux-$CARCH
        install -m755 bin/swift-build-tool "${D}/usr/bin"
    )
    (
        cd swiftpm-linux-$CARCH
        install -m755 debug/swift-build "${D}/usr/bin"

        install -dm755 "${D}/usr/lib/swift/pm"
        install -m755 lib/swift/pm/libPackageDescription.so "${D}/usr/lib/swift/pm"
        install -m644 lib/swift/pm/PackageDescription.swiftmodule "${D}/usr/lib/swift/pm"
    )
    (
        cd foundation-linux-$CARCH
        install -m755 Foundation/libFoundation.so "${D}/usr/lib/swift/linux/"
        install -m644 Foundation/Foundation.swiftdoc "${D}/usr/lib/swift/linux/$CARCH"
        install -m644 Foundation/Foundation.swiftmodule "${D}/usr/lib/swift/linux/$CARCH"

        umask 0022
        cp -r Foundation/usr/lib/swift/CoreFoundation "${D}/usr/lib/swift/"
    )
    (
        cd xctest-linux-$CARCH
        install -m755 libXCTest.so "${D}/usr/lib/swift/linux/"
        install -m644 XCTest.swiftdoc "${D}/usr/lib/swift/linux/$CARCH"
        install -m644 XCTest.swiftmodule "${D}/usr/lib/swift/linux/$CARCH"
    )

	# build lldb only when requested
	if use lldb; then
        cd lldb-linux-$CARCH
        DESTDIR="${D}" ninja install
	fi

    # License file
    install -dm755 "${D}/usr/share/licenses/swift"
    install -m644 "${S}/swift/LICENSE.txt" "${D}/usr/share/licenses/swift"
}
