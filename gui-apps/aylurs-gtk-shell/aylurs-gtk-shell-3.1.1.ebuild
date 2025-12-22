EAPI=8

inherit meson

DESCRIPTION="Aylurs's Gtk Shell (AGS), An eww inspired gtk widget system."
HOMEPAGE="https://github.com/Aylur/ags"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://github.com/Aylur/ags/releases/download/v${PV}/ags-v${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND="
	dev-lang/go
	gui-libs/gtk4-layer-shell
	dev-libs/gjs
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/ags"
