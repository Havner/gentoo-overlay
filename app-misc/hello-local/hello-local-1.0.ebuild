EAPI=8

DESCRIPTION="My test local package"
HOMEPAGE="https://example.com"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S=${WORKDIR}

# This package has no fetchable sources
src_unpack() {
	cat > "hello-local" <<'EOF'
#!/bin/sh
echo "Hello from Havner repo!"
EOF
	chmod +x "hello-local"

	return 0
}

src_install() {
	default

	exeinto /usr/bin
	doexe hello-local
}
