EAPI=8

DESCRIPTION="WIFI firmware for the T2 MacBookPro 16\" 2019"
HOMEPAGE="https://apple.com"
LICENSE="linux-fw-redistributable"
SLOT="0"
KEYWORDS="~amd64"

# This package has no fetchable sources
src_unpack() {
	mkdir "${S}"
	tar xf "${FILESDIR}/${P}.tar.xz" -C "${S}"
}

src_install() {
	insinto /lib/firmware/brcm
	doins -r *
}
