EAPI=8

inherit meson vala gnome2-utils

DESCRIPTION="Collection of libraries designed to serve as the foundation for desktop shells"
HOMEPAGE="https://github.com/Aylur/astal"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/vala[valadoc]
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/gobject-introspection
	x11-libs/gdk-pixbuf:2
	sys-libs/pam
	media-sound/libcava
	gnome-base/gvfs
	net-misc/networkmanager[vala]
	dev-libs/wayland
	gui-libs/appmenu-glib-translator
	media-video/wireplumber
"
DEPEND="${RDEPEND}"

	# =gui-libs/astal-${PV}

S=${WORKDIR}/astal

ASTAL_LIBS="
	lib/apps
	lib/auth
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
	lib/tray
	lib/wayland-glib
	lib/wireplumber
"

src_unpack() {
	tar xf "${FILESDIR}/astal-${PV}.tar.gz"
}

src_configure() {
	# why is it needed? shouldn't vala eclass define those by itself?
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	export VALADOC="$(type -P valadoc-$(vala_best_api_version))"
	export VAPIGEN="$(type -P vapigen-$(vala_best_api_version))"

	for lib in $ASTAL_LIBS; do
		(
			EMESON_SOURCE=${S}/$lib
			BUILD_DIR="${WORKDIR}"/$(basename "${lib}")_build
			meson_src_configure
		)
	done
}

src_compile() {
	for lib in $ASTAL_LIBS; do
		(
			EMESON_SOURCE=${S}/$lib
			BUILD_DIR="${WORKDIR}"/$(basename "${lib}")_build
			meson_src_compile
		)
	done
}

src_install() {
	for lib in $ASTAL_LIBS; do
		(
			EMESON_SOURCE=${S}/$DIR
			BUILD_DIR="${WORKDIR}"/$(basename "${lib}")_build
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
