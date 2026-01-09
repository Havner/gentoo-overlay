EAPI=8

inherit meson

PROPERTIES+=" live"

DESCRIPTION="A panel built for Hyprland with Astal"
HOMEPAGE="https://github.com/Jas-SinghFSU/HyprPanel"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="optional laptop"

# this also includes most of the optional deps
RDEPEND="
	net-libs/nodejs[npm]
	gui-apps/aylurs-gtk-shell
	gui-libs/astal-gjs[gtk3]
	gui-libs/astal-libs
	x11-libs/gtksourceview:3.0
	net-libs/libsoup:3.0
	media-video/wireplumber
	gnome-base/libgtop
	net-misc/networkmanager
	gui-apps/wl-clipboard
	sys-power/upower
	gnome-base/gvfs
	dev-lang/dart-sass
	media-fonts/nerdfonts[jetbrainsmono]
	optional? (
		gui-wm/hyprland-contrib
		gui-apps/wf-recorder
		gui-apps/hyprpicker
		gui-apps/hyprsunset
		sys-process/btop
		x11-misc/matugen
		gui-apps/swww
	)
	laptop? (
		app-misc/brightnessctl
		net-wireless/bluez
		sys-power/power-profiles-daemon
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/"${PN}"-fix-terminal-option.patch
	"${FILESDIR}"/"${PN}"-fix-brightness-2.patch
	"${FILESDIR}"/"${PN}"-shorter-bluetooth-2.patch
	"${FILESDIR}"/"${PN}"-bluetooth-connect-by-name.patch
)

S="${WORKDIR}/HyprPanel"

## taken from net-misc/sunshine:
# Make npm behave.
export npm_config_audit=false
export npm_config_color=false
export npm_config_foreground_scripts=true
export npm_config_loglevel=verbose
export npm_config_optional=true # https://github.com/npm/cli/issues/4828
export npm_config_progress=false
export npm_config_save=false

src_unpack() {
	tar xf "${FILESDIR}/${P}.tar.gz"

	## taken from net-misc/sunshine:
	# This downloads things so must go in src_unpack to avoid the sandbox.
	cd "${S}" || die
	npm install || die
}
