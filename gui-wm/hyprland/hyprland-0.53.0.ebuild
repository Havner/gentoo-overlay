# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland"
SRC_URI="https://github.com/hyprwm/${PN^}/releases/download/v${PV}/source-v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="X systemd"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-source"

# hyprpm (hyprland plugin manager) requires the dependencies at runtime
# so that it can clone, compile and install plugins.
HYPRPM_RDEPEND="
	app-alternatives/ninja
	>=dev-build/cmake-3.30
	dev-build/meson
	dev-vcs/git
	virtual/pkgconfig
	dev-cpp/tomlplusplus
	>=dev-cpp/glaze-6.0.0
"
RDEPEND="
	${HYPRPM_RDEPEND}
	>=dev-libs/udis86-1.7.2
	media-libs/libglvnd
	>=gui-libs/aquamarine-0.9.3
	>=dev-libs/hyprlang-0.6.7
	>=gui-libs/hyprcursor-0.1.13
	>=gui-libs/hyprutils-0.11.0
	>=dev-libs/hyprgraphics-0.1.6
	>=x11-libs/libxkbcommon-1.11.0
	sys-apps/util-linux
	>=dev-libs/wayland-1.22.90
	>=dev-libs/wayland-protocols-1.45
	x11-libs/cairo
	x11-libs/pango
	x11-libs/pixman
	x11-libs/libXcursor
	x11-libs/libdrm
	>=dev-libs/libinput-1.28
	media-libs/mesa
	dev-libs/glib:2
	dev-libs/re2
	dev-cpp/muParser
	X? (
		x11-libs/libxcb
		x11-base/xwayland
		x11-libs/xcb-util-errors
		x11-libs/xcb-util-wm
	)
	>=dev-libs/hyprland-protocols-0.6.4
	gui-apps/hyprland-guiutils
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-util/wayland-scanner
	>=dev-util/hyprwayland-scanner-0.4.5
"

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DNO_XWAYLAND=$(usex X OFF ON)
		-DNO_SYSTEMD=$(usex systemd OFF ON)
	)
	cmake_src_configure
}
