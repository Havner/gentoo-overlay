# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The hyprland cursor format, library and utilities"
HOMEPAGE="https://github.com/hyprwm/hyprcursor"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

# Disable tests since as per upstream, tests require a theme to be installed
# See also https://github.com/hyprwm/hyprcursor/commit/94361fd8a75178b92c4bb24dcd8c7fac8423acf3
RESTRICT="test"

RDEPEND="
	>=dev-libs/hyprlang-0.4.2
	dev-libs/libzip
	x11-libs/cairo
	gnome-base/librsvg:2
	dev-cpp/tomlplusplus
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"
