EAPI=8

inherit cmake

DESCRIPTION="QT6 Theme Provider for Hyprland. Compatible with KDE, replaces qt6ct"
HOMEPAGE="https://github.com/hyprwm/hyprqt6engine"
SRC_URI="https://github.com/hyprwm/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kde"

RDEPEND="
	gui-libs/hyprutils
	dev-libs/hyprlang
	kde? (
		kde-frameworks/kconfig:6
		kde-frameworks/kcolorscheme:6
		kde-frameworks/kiconthemes:6
	)
"
DEPEND="${RDEPEND}"
