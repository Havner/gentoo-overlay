# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd udev unpacker

MY_PV=${PV/_p/-}

DESCRIPTION="DisplayLink USB Graphics Software (userspace manager for evdi)"
HOMEPAGE="https://www.synaptics.com/products/displaylink-graphics"
SRC_URI="https://www.synaptics.com/sites/default/files/exe_files/2026-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu$(ver_cut 1-2)-EXE.zip -> ${P}.zip"
S="${WORKDIR}/${PN}"

LICENSE="DisplayLink-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"
RESTRICT="bindist mirror strip"

RDEPEND="
	>=x11-drivers/evdi-1.15.1
	dev-libs/libusb:1
	sys-apps/util-linux
	virtual/udev
"
BDEPEND="app-arch/unzip"

QA_PREBUILT="opt/displaylink/DisplayLinkManager"

src_unpack() {
	unpack ${P}.zip
	mkdir "${S}" || die
	cd "${S}" || die
	unpack_makeself "${WORKDIR}/run/${PN}-driver-${MY_PV}.run"
}

src_install() {
	local bindir
	case ${ARCH} in
		amd64) bindir=x64-ubuntu-1604 ;;
		x86) bindir=x86-ubuntu-1604 ;;
		arm64) bindir=aarch64-linux-gnu ;;
		arm) bindir=arm-linux-gnueabihf ;;
		*) die "unsupported ARCH ${ARCH}" ;;
	esac

	exeinto /opt/displaylink
	doexe ${bindir}/DisplayLinkManager
	insinto /opt/displaylink
	doins *.spkg

	keepdir /var/log/displaylink

	systemd_dounit "${FILESDIR}"/displaylink-driver.service
	udev_dorules "${FILESDIR}"/99-displaylink.rules

	dodoc LICENSE 3rd_party_licences.txt "${WORKDIR}"/run/*Release\ Notes.txt
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
