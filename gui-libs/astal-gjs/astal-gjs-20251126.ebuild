EAPI=8

inherit meson vala

DESCRIPTION="Collection of libraries designed to serve as the foundation for desktop shells"
HOMEPAGE="https://github.com/Aylur/astal"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gtk3 +gtk4"

REQUIRED_USE="|| ( gtk3 gtk4 )"

RDEPEND="
	=gui-libs/astal-io-${PV}
	gtk3? ( =gui-libs/astal-gtk3-${PV} )
	gtk4? ( =gui-libs/astal-gtk4-${PV} )
"
DEPEND="${RDEPEND}"

ASTAL_LIB="lang/gjs"
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
