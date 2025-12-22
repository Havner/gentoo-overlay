EAPI=8

inherit meson vala

DESCRIPTION="Collection of libraries designed to serve as the foundation for desktop shells"
HOMEPAGE="https://github.com/Aylur/astal"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/vala[valadoc]
	dev-libs/glib:2
	=gui-libs/astal-io-${PV}
	x11-libs/gtk+:3[wayland]
	x11-libs/gdk-pixbuf:2
	gui-libs/gtk-layer-shell[vala]
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	dev-libs/gobject-introspection
"
DEPEND="${RDEPEND}"

ASTAL_LIB="lib/astal/gtk3"
S=${WORKDIR}/astal/${ASTAL_LIB}

src_unpack() {
	tar xf "${FILESDIR}/astal-${PV}.tar.gz"
}

src_configure() {
	# why is it needed? shouldn't vala eclass define those by itself?
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	export VALADOC="$(type -P valadoc-$(vala_best_api_version))"

	meson_src_configure
}
