# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hyprland's system information GUI application"
HOMEPAGE="https://wiki.hyprland.org/Hypr-Ecosystem/hyprsysteminfo"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/hyprtoolkit
	>=gui-libs/hyprutils-0.10.2
	x11-libs/libdrm
	sys-apps/pciutils
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"
