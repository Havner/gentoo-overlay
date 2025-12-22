EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="Mature, stable, and powerful grade CSS extension language"
HOMEPAGE="https://sass-lang.com/dart-sass/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://github.com/sass/dart-sass/releases/download/${PV}/${P}-linux-x64.tar.gz"

S="${WORKDIR}/${PN}"


src_install() {
	exeinto /usr/libexec/dart-sass
	doexe src/dart
	doexe src/sass.snapshot
	dobin "${FILESDIR}"/sass
}
