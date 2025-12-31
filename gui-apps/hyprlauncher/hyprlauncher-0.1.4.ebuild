# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A multipurpose and versatile launcher / picker for Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprlauncher"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/hyprtoolkit
	x11-libs/pixman
	x11-libs/libdrm
	>=gui-libs/hyprutils-0.10.2
	dev-libs/hyprwire
	dev-libs/icu
	dev-libs/hyprlang
	media-libs/fontconfig
	sci-libs/libqalculate
	gui-apps/wl-clipboard
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"
