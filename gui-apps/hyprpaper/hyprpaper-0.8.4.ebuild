# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple and fast wallpaper utility for Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprpaper"
SRC_URI="https://github.com/hyprwm/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/hyprlang-0.6.0
	>=gui-libs/hyprutils-0.2.4
	dev-libs/wayland
	>=gui-libs/hyprtoolkit-0.4.1
	dev-libs/hyprwire
	x11-libs/pixman
	x11-libs/libdrm
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-util/wayland-scanner
	>=dev-util/hyprwayland-scanner-0.4.0
"
