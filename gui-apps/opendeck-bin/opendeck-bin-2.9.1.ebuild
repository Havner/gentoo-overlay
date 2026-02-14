EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="Linux software for your Elgato Stream Deck"
HOMEPAGE="https://github.com/nekename/OpenDeck"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://github.com/nekename/OpenDeck/releases/download/v${PV}/opendeck_${PV}_amd64.deb"

S="${WORKDIR}"

RDEPEND="
	net-libs/webkit-gtk:4.1
	dev-libs/libayatana-appindicator
	net-misc/curl
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf:2
	x11-libs/libxcb
	dev-libs/openssl
"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	dodir /etc /usr
	dodir /usr/lib/udev/rules.d
	cp -aR "${S}"/etc/udev/rules.d/* "${ED}"/usr/lib/udev/rules.d/ || die
	cp -aR "${S}"/usr/* "${ED}"/usr/ || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
