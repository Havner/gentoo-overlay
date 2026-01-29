# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A graceful shutdown/logout utility for Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprshutdown"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/hyprtoolkit
	>=gui-libs/hyprutils-0.11.0
	x11-libs/pixman
	x11-libs/libdrm
	>=dev-cpp/glaze-6.1.0
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"
