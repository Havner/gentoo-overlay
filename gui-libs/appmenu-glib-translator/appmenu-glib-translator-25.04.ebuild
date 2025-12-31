EAPI=8

inherit meson vala

DESCRIPTION="GLib library to translate DBusMenu menus into GMenuModels"
HOMEPAGE="https://gitlab.com/vala-panel-project/vala-panel-appmenu"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://gitlab.com/-/project/6865053/uploads/ad1d7fdea9c44ab23feb990086669866/${P}.tar.xz"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
"
DEPEND="${RDEPEND}"

src_configure() {
	# why is it needed? shouldn't vala eclass define by itlself?
	export VAPIGEN="$(type -P vapigen-$(vala_best_api_version))"

	meson_src_configure
}
