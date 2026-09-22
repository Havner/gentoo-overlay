EAPI=8

inherit meson

DESCRIPTION="Vulkan Wayland HDR WSI Layers for NVIDIA"
HOMEPAGE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

VKROOTS=20733b938267dcac60f6ac105dbb757f9cc8df9c

SRC_URI="https://github.com/Havner/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
         https://github.com/misyltoad/vkroots/archive/${VKROOTS}.zip -> vkroots-${VKROOTS}.zip"

RDEPEND="dev-libs/wayland"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}/subprojects
	rmdir vkroots
	unpack vkroots-${VKROOTS}.zip
	mv vkroots-${VKROOTS} vkroots
}

src_install() {
	meson_src_install

	rm -f "${ED}/usr/lib64/pkgconfig/vkroots.pc" || die
	rm -f "${ED}/usr/include/vkroots.h" || die
}
