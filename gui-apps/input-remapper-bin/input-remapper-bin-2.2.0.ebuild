EAPI=8

#PYTHON_COMPAT=( python3_13 )

inherit unpacker xdg-utils

DESCRIPTION="An easy to use tool for Linux to change the behaviour of your input devices"
HOMEPAGE="https://github.com/sezanzeb/input-remapper"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="( ${PYTHON_REQUIRED_USE} )"

SRC_URI="https://github.com/sezanzeb/input-remapper/releases/download/${PV}/input-remapper-${PV}.deb"

S="${WORKDIR}"

RDEPEND="
dev-python/evdev
dev-python/packaging
dev-python/psutil
dev-python/pycairo
dev-python/pydantic
dev-python/pydbus
dev-python/pygobject
dev-python/setuptools
x11-libs/gtk+:3
x11-libs/gtksourceview:4
"

src_unpack() {
	unpack_deb "${A}"

	# fix python
	mv usr/lib/python3 usr/lib/python3.13
	mv usr/lib/python3.13/dist-packages usr/lib/python3.13/site-packages

	# remove leftovers
	rmdir usr/local/lib
	rmdir usr/local
	rm usr/share/input-remapper/99-input-remapper.rules
	rm usr/share/input-remapper/inputremapper.Control.conf
	rm usr/share/input-remapper/input-remapper.glade~
	rm usr/share/input-remapper/input-remapper.policy
	rm usr/share/input-remapper/input-remapper.service
	rm usr/share/input-remapper/input-remapper-autoload.desktop
	rm usr/share/input-remapper/input-remapper-gtk.desktop
	rm usr/share/input-remapper/io.github.sezanzeb.input_remapper.metainfo.xml
}

src_install() {
	dodir /etc /usr
	cp -aR "${S}"/etc/* "${ED}"/etc/ || die
	cp -aR "${S}"/usr/* "${ED}"/usr/ || die
	newinitd "${FILESDIR}/input-remapper.initd" input-remapper
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
