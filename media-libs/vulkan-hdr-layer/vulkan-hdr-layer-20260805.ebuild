EAPI=8

inherit meson

DESCRIPTION="Vulkan Wayland HDR WSI Layer"
HOMEPAGE="https://github.com/Zamundaaa/VK_hdr_layer"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/wayland"
DEPEND="${RDEPEND}"

S=${WORKDIR}/VK_hdr_layer

# This package has no fetchable sources
src_unpack() {
	tar xf "${FILESDIR}/${P}.tar.gz"
}

src_install() {
	meson_src_install

	rm -f "${ED}/usr/lib64/pkgconfig/vkroots.pc" || die
	rm -f "${ED}/usr/include/vkroots.h" || die
}
