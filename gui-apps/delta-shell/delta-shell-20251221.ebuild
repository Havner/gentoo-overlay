EAPI=8

inherit meson

DESCRIPTION="A desktop shell based on Ags. Currently supports Hyprland"
HOMEPAGE="https://github.com/sinomor/delta-shell"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+optional laptop"

RDEPEND="
	gui-apps/aylurs-gtk-shell
	gui-libs/astal-libs
	dev-lang/dart-sass
	optional? (
		app-misc/cliphist
		gui-apps/wl-clipboard
		media-video/gpu-screen-recorder
		app-misc/geoclue
		net-wireless/bluez
		gnome-base/libgtop
	)
	laptop? (
		app-misc/brightnessctl
		sys-power/power-profiles-daemon
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-drop-niri.patch
)

S="${WORKDIR}/${PN}"
