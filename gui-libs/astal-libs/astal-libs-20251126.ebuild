EAPI=8

inherit meson vala gnome2-utils

DESCRIPTION="Collection of libraries designed to serve as the foundation for desktop shells"
HOMEPAGE="https://github.com/Aylur/astal"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/astal
	dev-libs/json-glib
	sys-libs/pam
	gnome-base/gvfs
	net-misc/networkmanager[vala]
	x11-libs/gdk-pixbuf:2
	media-sound/libcava
	media-video/wireplumber
	gui-libs/appmenu-glib-translator
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/astal

ASTAL_DIRS="
	lib/apps
	lib/auth
	lib/auth/include
	lib/auth/src
	lib/battery
	lib/bluetooth
	lib/cava
	lib/greet
	lib/hyprland
	lib/mpris
	lib/network
	lib/notifd
	lib/powerprofiles
	lib/river
	lib/river/include
	lib/river/protocols/
	lib/river/src
	lib/tray
	lib/wayland-glib
	lib/wireplumber
	lib/wireplumber/include
	lib/wireplumber/include/astal/wireplumber
	lib/wireplumber/src
"

# This package has no fetchable sources
src_unpack() {
	tar xf "${FILESDIR}/astal-${PV}.tar.gz"
}

src_configure() {
	# why is it needed? shouldn't vala eclass define by itlself?
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	export VALADOC="$(type -P valadoc-$(vala_best_api_version))"
	export VAPIGEN="$(type -P vapigen-$(vala_best_api_version))"

	for dir in $ASTAL_DIRS; do
		(
			EMESON_SOURCE=${S}/$dir
			BUILD_DIR="${WORKDIR}"/$(basename "${dir}")_build
			meson_src_configure
		)
	done
}

src_compile() {
	for dir in $ASTAL_DIRS; do
		(
			EMESON_SOURCE=${S}/$dir
			BUILD_DIR="${WORKDIR}"/$(basename "${dir}")_build
			meson_src_compile
		)
	done
}

src_install() {
	for dir in $ASTAL_DIRS; do
		(
			EMESON_SOURCE=${S}/$DIR
			BUILD_DIR="${WORKDIR}"/$(basename "${dir}")_build
			meson_src_install
		)
	done
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
