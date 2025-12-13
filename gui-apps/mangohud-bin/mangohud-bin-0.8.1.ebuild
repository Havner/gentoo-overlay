EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more."
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${PV}/MangoHud-${PV}.r0.gfea4292.tar.gz"

S="${WORKDIR}/MangoHud"

RDEPEND="
	dev-libs/wayland
	dev-libs/libffi
	x11-libs/libxkbcommon
"

src_install() {
	tar xf MangoHud-package.tar
	dodir /usr
	cp -aR "${S}"/usr/* "${ED}"/usr/ || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
