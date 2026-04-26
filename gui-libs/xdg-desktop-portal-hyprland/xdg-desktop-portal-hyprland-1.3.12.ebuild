# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="xdg-desktop-portal backend for Hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	>=media-video/pipewire-1.2.0
	x11-libs/libdrm
	media-libs/mesa
	>=dev-libs/hyprlang-0.2.0
	>=gui-libs/hyprutils-0.2.6
	dev-libs/hyprland-protocols
	>=dev-cpp/sdbus-c++-2.0.0
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtwayland:6
	|| (
		sys-libs/basu
		elogind? ( >=sys-auth/elogind-237 )
		systemd? ( >=sys-apps/systemd-237 )
	)
"
RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-util/wayland-scanner
	>=dev-util/hyprwayland-scanner-0.4.2
"

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}
