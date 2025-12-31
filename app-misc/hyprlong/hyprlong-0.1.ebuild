# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="A very very simple program that allows to properly bind long presses in hyprland"
HOMEPAGE="https://github.com/Havner/hyprlong"
SRC_URI="https://github.com/Havner/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"

# src_unpack() {
# 	cargo_src_unpack
# 	tar xf "${FILESDIR}/${P}.tar.gz"
# }

# src_install() {
# 	cargo_src_install

# 	insinto /usr/share/tiny-dfr
# 	doins share/tiny-dfr/*

# 	udev_dorules etc/udev/rules.d/*
# 	systemd_dounit etc/systemd/system/*
# 	newinitd "${FILESDIR}"/${PN}.initd ${PN}
# }
