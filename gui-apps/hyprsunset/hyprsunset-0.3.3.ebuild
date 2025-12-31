# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An application to enable a blue-light filter on Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprsunset"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	>=gui-libs/hyprutils-0.2.3
	dev-libs/hyprlang
	>=dev-libs/hyprland-protocols-0.4.0
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-util/wayland-scanner
	>=dev-util/hyprwayland-scanner-0.4.0
"
