# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hyprland utilities library used across the ecosystem"
HOMEPAGE="https://github.com/hyprwm/hyprutils"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/pixman
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"
