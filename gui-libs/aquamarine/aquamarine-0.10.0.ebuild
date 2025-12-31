# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Aquamarine is a very light linux rendering backend library"
HOMEPAGE="https://github.com/hyprwm/aquamarine"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# Upstream states that the simpleWindow test is broken, see bug 936653
RESTRICT="test"
RDEPEND="
	>=sys-auth/seatd-0.8.0
	>=dev-libs/libinput-1.26.1
	dev-libs/wayland
	dev-libs/wayland-protocols
	>=gui-libs/hyprutils-0.8.4
	x11-libs/pixman
	x11-libs/libdrm
	media-libs/mesa
	virtual/libudev
	media-libs/libdisplay-info
	sys-apps/hwdata
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-util/wayland-scanner
	>=dev-util/hyprwayland-scanner-0.4.0
"

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}
