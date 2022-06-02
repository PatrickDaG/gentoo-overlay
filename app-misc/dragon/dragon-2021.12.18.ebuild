# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3


DESCRIPTION="Drag and drop source/target for X"
HOMEPAGE="https://github.com/mwh/dragon"
EGIT_REPO_URI="https://github.com/mwh/dragon"
EGIT_COMMIT_DATE="$PV"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i 's|$(HOME)/.local|${ED}/usr|g' Makefile || die "sed failed"
	sed -e 's/\(`pkg-config --cflags .*`\) \(`pkg-config --libs .*`\)/\1 $(CFLAGS) \2 $(LDFLAGS)/' \
		-i Makefile || die "sed failed"
}

src_install() {
	dobin dragon
	dodoc README
	doman dragon.1
}
