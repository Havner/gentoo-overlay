# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hyprland's idle daemon"
HOMEPAGE="https://github.com/hyprwm/hypridle"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	>=dev-libs/hyprlang-0.6.0
	>=gui-libs/hyprutils-0.2.0
	dev-cpp/sdbus-c++:0/2
	>=dev-libs/hyprland-protocols-0.6.0
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-0.1.5-fix-CFLAGS-CXXFLAGS.patch"
)
