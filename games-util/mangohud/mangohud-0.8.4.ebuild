# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit flag-o-matic python-single-r1 meson-multilib toolchain-funcs

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

# Check subprojects/vulkan-headers.wrap for this value
VK_HEADERS_VER="1.4.346"

IMGUI_VER="1.91.6"
IMGUI_MESON_WRAP_VER="3"
IMPLOT_VER="0.16"
IMPLOT_MESON_WRAP_VER="1"


SRC_URI="
	https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VK_HEADERS_VER}.tar.gz
		-> Vulkan-Headers-${VK_HEADERS_VER}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Utility-Libraries/archive/v${VK_HEADERS_VER}.tar.gz
		-> Vulkan-Utility-Libraries-${VK_HEADERS_VER}.tar.gz
	https://github.com/ocornut/imgui/archive/v${IMGUI_VER}.tar.gz
		-> imgui-${IMGUI_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/imgui_${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}/get_patch
		-> imgui-${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}-meson-wrap.zip
	https://github.com/epezent/implot/archive/v${IMPLOT_VER}.tar.gz
		-> implot-${IMPLOT_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/implot_${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}/get_patch
		-> implot-${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}-meson-wrap.zip
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud.git"
else
	SRC_URI+="https://github.com/flightlessmango/MangoHud/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/MangoHud-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+dbus +X xnvctrl wayland mangoapp mangohudctl mangoplot video_cards_nvidia test"
RESTRICT="test" # tests aren't enabled upstream

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia )
	mangoapp? ( X )
"

BDEPEND="
	dev-util/glslang
	test? ( dev-util/cmocka )
	$(python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]')
"

DEPEND="
	${PYTHON_DEPS}
	dev-libs/spdlog:=[${MULTILIB_USEDEP}]
	dev-libs/libfmt:=[${MULTILIB_USEDEP}]
	dev-cpp/nlohmann_json
	x11-libs/libxkbcommon:=[${MULTILIB_USEDEP}]
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	mangoapp? (
		media-libs/glfw[X(+)?,wayland(+)?]
		media-libs/glew
	)
"

RDEPEND="
	${DEPEND}
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	mangoplot? (
		media-fonts/lato
		$(python_gen_cond_dep '
			|| (
				dev-python/matplotlib[gtk3,${PYTHON_USEDEP}]
				dev-python/matplotlib[qt5(-),${PYTHON_USEDEP}]
				dev-python/matplotlib[qt6(-),${PYTHON_USEDEP}]
				dev-python/matplotlib[wxwidgets,${PYTHON_USEDEP}]
			)
		')
	)
"

src_unpack() {
	default

	if [[ $PV == 9999 ]]; then
		git-r3_src_unpack
	fi

	unpack Vulkan-Headers-${VK_HEADERS_VER}.tar.gz
	unpack Vulkan-Utility-Libraries-${VK_HEADERS_VER}.tar.gz

	unpack imgui-${IMGUI_VER}.tar.gz
	unpack imgui-${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}-meson-wrap.zip
	unpack implot-${IMPLOT_VER}.tar.gz
	unpack implot-${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}-meson-wrap.zip
}

src_prepare() {
	default

	mv "${WORKDIR}/Vulkan-Headers-${VK_HEADERS_VER}" "${S}/subprojects/" || die
	mv "${WORKDIR}/Vulkan-Utility-Libraries-${VK_HEADERS_VER}" "${S}/subprojects/" || die

	mv "${WORKDIR}/imgui-${IMGUI_VER}" "${S}/subprojects/" || die
	mv "${WORKDIR}/implot-${IMPLOT_VER}" "${S}/subprojects/" || die

	pushd subprojects || die
	mv packagefiles/vulkan-headers/* Vulkan-Headers-${VK_HEADERS_VER} || die
	mv packagefiles/vulkan-utility-libraries/* Vulkan-Utility-Libraries-${VK_HEADERS_VER} || die
	# save some space when using FEATURES=installsources
	rm -rf "*.wrap" "{packagefiles/imgui-0.16}" || die
	popd || die
}

multilib_src_configure() {
	# workaround for lld
	# https://github.com/flightlessmango/MangoHud/issues/1240
	if tc-ld-is-lld; then
		append-ldflags -Wl,--undefined-version
	fi

	local emesonargs=(
		-Dappend_libdir_mangohud=false
		-Dinclude_doc=false
		-Duse_system_spdlog=enabled
		$(meson_feature video_cards_nvidia with_nvml)
		$(meson_feature xnvctrl with_xnvctrl)
		$(meson_feature X with_x11)
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
		$(meson_use mangoapp mangoapp)
		$(meson_use mangohudctl mangohudctl)
		$(meson_feature mangoplot mangoplot)
		$(meson_feature test tests)
	)
	meson_src_configure
}

pkg_postinst() {
	if use video_cards_nvidia; then
		einfo ""
		einfo "You need nvidia-drivers[multilib?] if running on an NVidia hardware."
		einfo ""
	fi
	if use xnvctrl; then
		einfo ""
		einfo "You need nvidia-drivers[static-libs] if running on an NVidia hardware."
		einfo ""
	fi
	if ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi
}
