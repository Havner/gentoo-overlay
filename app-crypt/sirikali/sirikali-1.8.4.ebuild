# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake

DESCRIPTION="A Qt/C++ GUI front end to some encrypted filesystems and sshfs"
HOMEPAGE="
	https://mhogomchungu.github.io/sirikali/
	https://github.com/mhogomchungu/sirikali
"
SRC_URI="https://github.com/mhogomchungu/${PN}/releases/download/${PV}/${P}.tar.xz"
S="${WORKDIR}/SiriKali-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring kwallet +pwquality test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-libs/libgcrypt:0=
	gnome-keyring? ( app-crypt/libsecret )
	kwallet? ( kde-frameworks/kwallet )
	pwquality? ( dev-libs/libpwquality )
"

src_configure() {
	local NO_SECRET_SUPPORT=true
	use kwallet && NO_SECRET_SUPPORT=false
	use gnome-keyring && NO_SECRET_SUPPORT=false
	local mycmakeargs=(
		-DNOSECRETSUPPORT=${NO_SECRET_SUPPORT}
		-DBUILD_WITH_QT6=true
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
