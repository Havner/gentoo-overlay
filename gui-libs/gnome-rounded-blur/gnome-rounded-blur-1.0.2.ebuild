EAPI=8

inherit meson

DESCRIPTION="GNOME rounded blur library"
HOMEPAGE="https://github.com/kancko/gnome-rounded-blur"
SRC_URI="https://github.com/kancko/gnome-rounded-blur/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=x11-wm/mutter-51.0
	dev-libs/glib
"
DEPEND="${RDEPEND}"
