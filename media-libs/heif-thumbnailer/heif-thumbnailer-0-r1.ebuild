EAPI=8

DESCRIPTION="Nautilus HEIF/HEIC thumbnailer"
HOMEPAGE="https://github.com/strukturag/libheif"
LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

S=${WORKDIR}

RDEPEND="media-libs/libheif[gdk-pixbuf]"
DEPEND="${RDEPEND}"

# This package has no fetchable sources
src_unpack() {
	cat > "gdk-pixbuf-thumbnailer-heif.thumbnailer" <<'EOF'
[Thumbnailer Entry]
TryExec=/usr/bin/gdk-pixbuf-thumbnailer
Exec=/usr/bin/gdk-pixbuf-thumbnailer -s %s %u %o
MimeType=image/heif;image/heif-sequence;image/heic;image/heic-sequence;
EOF
}

src_install() {
	default

	insinto /usr/share/thumbnailers
	doins gdk-pixbuf-thumbnailer-heif.thumbnailer
}
