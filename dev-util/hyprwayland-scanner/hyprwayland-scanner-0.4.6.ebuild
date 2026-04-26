# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="A Hyprland implementation of wayland-scanner, in and for C++"
HOMEPAGE="https://github.com/hyprwm/hyprwayland-scanner/"
SRC_URI="https://github.com/hyprwm/hyprwayland-scanner/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/pugixml"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"
