EAPI=8

inherit unpacker xdg udev

DESCRIPTION="Linuxtrack Modernized (Proton & Qt6 Edition)"
HOMEPAGE="https://github.com/StarTuz/linuxtrack-Qt6-Wayland"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://github.com/StarTuz/linuxtrack-Qt6-Wayland/releases/download/v${PV}/linuxtrack_${PV}_amd64.deb"

S="${WORKDIR}"

RDEPEND="
	dev-qt/qtbase:6
	dev-qt/qttools:6
	dev-libs/mxml:0
	media-libs/libv4l
	x11-libs/libX11
"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	dodir /opt /usr
	cp -aR "${S}"/opt/* "${ED}"/opt/ || die
	cp -aR "${S}"/usr/* "${ED}"/usr/ || die
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
}

pkg_postrm() {
	xdg_pkg_postinst
	udev_reload
}
