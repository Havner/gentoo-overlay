EAPI=8

inherit meson vala

DESCRIPTION="Collection of libraries designed to serve as the foundation for desktop shells"
HOMEPAGE="https://github.com/Aylur/astal"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/vala[valadoc]
	dev-libs/gobject-introspection
	x11-libs/gtk+:3[wayland]
	gui-libs/gtk[wayland]
	gui-libs/gtk-layer-shell[vala]
	gui-libs/gtk4-layer-shell[vala]
	x11-libs/gtksourceview:3.0[vala]
	x11-libs/gtksourceview:4[vala]
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/astal

ASTAL_DIRS="
	lib/astal/io
	lib/astal/gtk3
	lib/astal/gtk4
	lang/gjs
"

# This package has no fetchable sources
src_unpack() {
	tar xf "${FILESDIR}/${P}.tar.gz"
}

src_configure() {
	# why is it needed? shouldn't vala eclass define by itlself?
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	export VALADOC="$(type -P valadoc-$(vala_best_api_version))"

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
