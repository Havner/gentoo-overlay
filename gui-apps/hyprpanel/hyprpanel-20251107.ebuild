EAPI=8

inherit meson

PROPERTIES+=" live"

DESCRIPTION="A panel built for Hyprland with Astal"
HOMEPAGE="https://github.com/Jas-SinghFSU/HyprPanel"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-apps/aylurs-gtk-shell
	net-libs/nodejs[npm]
	media-video/wireplumber
	gnome-base/libgtop
	net-wireless/bluez
	net-misc/networkmanager
	gui-apps/wl-clipboard
	sys-power/upower
	gnome-base/gvfs
	media-fonts/nerdfonts[jetbrainsmono]
"
DEPEND="${RDEPEND}"
# it also needs sass binary (dart-sass)
# npm install -g sass

PATCHES=(
	"${FILESDIR}"/"${PN}"-fix-terminal-option.patch
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
