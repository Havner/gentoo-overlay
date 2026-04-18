# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hyprland's GPU-accelerated screen locking utility"
HOMEPAGE="https://github.com/hyprwm/hyprlock"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.35
	>=dev-libs/hyprlang-0.6.0
	media-libs/libglvnd
	x11-libs/libxkbcommon
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libdrm
	media-libs/mesa[opengl]
	>=gui-libs/hyprutils-0.11.0
	dev-cpp/sdbus-c++:0/2
	>=dev-libs/hyprgraphics-0.1.6
	sys-libs/pam
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-util/wayland-scanner
	>=dev-util/hyprwayland-scanner-0.4.4
"

PATCHES=(
	"${FILESDIR}/${PN}-0.4.1-fix-CFLAGS-CXXFLAGS.patch"
)
