# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit flag-o-matic python-single-r1 meson-multilib toolchain-funcs

MY_PV=$(ver_cut 1-3)
[[ -n "$(ver_cut 4-5)" ]] && MY_PV_REV="-$(ver_cut 4-5)"

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

VK_HEADERS_VER="1.3.283"
VK_HEADERS_MESON_WRAP_VER="1"
IMGUI_VER="1.91.6"
IMGUI_MESON_WRAP_VER="3"
IMPLOT_VER="0.16"
IMPLOT_MESON_WRAP_VER="1"

SRC_URI="
	https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VK_HEADERS_VER}.tar.gz
		-> vulkan-headers-${VK_HEADERS_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/vulkan-headers_${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}/get_patch
		-> vulkan-headers-${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}-meson-wrap.zip
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
	SRC_URI+="
		https://github.com/flightlessmango/MangoHud/archive/v${MY_PV}${MY_PV_REV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/MangoHud-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+dbus debug +X xnvctrl wayland mangoapp mangohudctl mangoplot video_cards_nvidia video_cards_amdgpu test"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia )
	mangoapp? ( X )
"

BDEPEND="
	app-arch/unzip
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
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
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

	[[ -n "${MY_PV_REV}" ]] && ( mv "${WORKDIR}/MangoHud-${MY_PV}${MY_PV_REV}" "${WORKDIR}/MangoHud-${PV}" || die )

	if [[ $PV == 9999 ]]; then
		git-r3_src_unpack
	fi

	unpack vulkan-headers-${VK_HEADERS_VER}.tar.gz
	unpack vulkan-headers-${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/Vulkan-Headers-${VK_HEADERS_VER}" "${S}/subprojects/" || die
	unpack imgui-${IMGUI_VER}.tar.gz
	unpack imgui-${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/imgui-${IMGUI_VER}" "${S}/subprojects/" || die
	unpack implot-${IMPLOT_VER}.tar.gz
	unpack implot-${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/implot-${IMPLOT_VER}" "${S}/subprojects/" || die
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
	)
	meson_src_configure
}

pkg_postinst() {
	if ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi
}
