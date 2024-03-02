add_rules(
    "mode.debug",
    "mode.release",
    "plugin.vsxmake.autoupdate"
)

set_project("h2quake")
set_version("0.0.0", {build = "%Y%m%d%H%M%S"})

set_allowedplats("windows", "macosx", "linux")

add_requires("libsdl", {configs = {shared = true}})
add_requires("openal-soft", {configs = {shared = true}})
add_requires("libcurl", {configs = {shared = true}})

add_defines("NOUNCRYPT", "USE_CURL", "USE_OPENAL")

if is_plat("windows") then
    add_defines("YQ2OSTYPE=\"Windows\"", "DEFAULT_OPENAL_DRIVER=\"openal32.dll\"")
elseif is_plat("macosx") then
    add_defines("YQ2OSTYPE=\"Darwin\"", "DEFAULT_OPENAL_DRIVER=\"libopenal.dylib\"")
    add_cxflags("-fPIC")
elseif is_plat("linux") then
    add_defines("YQ2OSTYPE=\"Linux\"", "DEFAULT_OPENAL_DRIVER=\"libopenal.so.1\"")
    add_links("m", "dl")
    add_cxflags("-fPIC")
end

if is_arch("x64", "x86_64", "amd64") then
    add_defines("YQ2ARCH=\"x86_64\"")
elseif is_arch("x86", "i386") then
    add_defines("YQ2ARCH=\"i386\"")
elseif is_arch("arm64", "aarch64") then
    add_defines("YQ2ARCH=\"aarch64\"")
end

if is_mode("debug") then
    add_defines("DEBUG")
end

if not is_plat("windows", "linux") then
    add_defines("IOAPI_NO_64")
end

target("common")
    set_kind("static")

    add_headerfiles("src/common/header/*.h")
    add_files(
        "src/backends/generic/misc.c",
        "src/common/argproc.c",
        "src/common/clientserver.c",
        "src/common/collision.c",
        "src/common/crc.c",
        "src/common/cmdparser.c",
        "src/common/cvar.c",
        "src/common/filesystem.c",
        "src/common/glob.c",
        "src/common/md4.c",
        "src/common/movemsg.c",
        "src/common/frame.c",
        "src/common/netchan.c",
        "src/common/pmove.c",
        "src/common/szone.c",
        "src/common/zone.c",
        "src/common/shared/flash.c",
        "src/common/shared/rand.c",
        "src/common/shared/shared.c",
        "src/common/unzip/ioapi.c",
        "src/common/unzip/unzip.c",
        "src/common/unzip/miniz/miniz.c",
        "src/common/unzip/miniz/miniz_tdef.c",
        "src/common/unzip/miniz/miniz_tinfl.c"
    )

    if is_plat("windows") then
        add_files(
            "src/backends/windows/main.c",
            "src/backends/windows/network.c",
            "src/backends/windows/system.c",
            "src/backends/windows/shared/hunk.c"
        )
    else
        add_files(
            "src/backends/unix/main.c",
            "src/backends/unix/network.c",
            "src/backends/unix/signalhandler.c",
            "src/backends/unix/system.c",
            "src/backends/unix/shared/hunk.c"
        )
    end

    add_packages("libcurl", "libsdl")

target("common_ded")
    set_kind("static")

    add_headerfiles("src/common/header/*.h")
    add_files(
        "src/backends/generic/misc.c",
        "src/common/argproc.c",
        "src/common/clientserver.c",
        "src/common/collision.c",
        "src/common/crc.c",
        "src/common/cmdparser.c",
        "src/common/cvar.c",
        "src/common/filesystem.c",
        "src/common/glob.c",
        "src/common/md4.c",
        "src/common/movemsg.c",
        "src/common/frame.c",
        "src/common/netchan.c",
        "src/common/pmove.c",
        "src/common/szone.c",
        "src/common/zone.c",
        "src/common/shared/flash.c",
        "src/common/shared/rand.c",
        "src/common/shared/shared.c",
        "src/common/unzip/ioapi.c",
        "src/common/unzip/unzip.c",
        "src/common/unzip/miniz/miniz.c",
        "src/common/unzip/miniz/miniz_tdef.c",
        "src/common/unzip/miniz/miniz_tinfl.c"
    )

    if is_plat("windows") then
        add_files(
            "src/backends/windows/main.c",
            "src/backends/windows/network.c",
            "src/backends/windows/system.c",
            "src/backends/windows/shared/hunk.c"
        )
    else
        add_files(
            "src/backends/unix/main.c",
            "src/backends/unix/network.c",
            "src/backends/unix/signalhandler.c",
            "src/backends/unix/system.c",
            "src/backends/unix/shared/hunk.c"
        )
    end

    add_defines("DEDICATED_ONLY")

    add_packages("libcurl", "libsdl")

target("quake2")
    set_kind("binary")

    add_headerfiles(
        "src/client/curl/header/*.h",
        "src/client/header/*.h",
        "src/client/input/header/*.h",
        "src/client/menu/header/*.h",
        "src/client/sound/header/*.h",
        "src/client/vid/header/*.h"
    )
    add_files(
        "src/client/cl_cin.c",
        "src/client/cl_console.c",
        "src/client/cl_download.c",
        "src/client/cl_effects.c",
        "src/client/cl_entities.c",
        "src/client/cl_input.c",
        "src/client/cl_inventory.c",
        "src/client/cl_keyboard.c",
        "src/client/cl_lights.c",
        "src/client/cl_main.c",
        "src/client/cl_network.c",
        "src/client/cl_parse.c",
        "src/client/cl_particles.c",
        "src/client/cl_prediction.c",
        "src/client/cl_screen.c",
        "src/client/cl_tempentities.c",
        "src/client/cl_view.c",
        "src/client/curl/download.c",
        "src/client/curl/qcurl.c",
        "src/client/input/sdl.c",
        "src/client/menu/menu.c",
        "src/client/menu/qmenu.c",
        "src/client/menu/videomenu.c",
        "src/client/sound/sdl.c",
        "src/client/sound/ogg.c",
        "src/client/sound/openal.c",
        "src/client/sound/qal.c",
        "src/client/sound/sound.c",
        "src/client/sound/wave.c",
        "src/client/vid/glimp_sdl.c",
        "src/client/vid/vid.c",
        "src/server/sv_cmd.c",
        "src/server/sv_conless.c",
        "src/server/sv_entities.c",
        "src/server/sv_game.c",
        "src/server/sv_init.c",
        "src/server/sv_main.c",
        "src/server/sv_save.c",
        "src/server/sv_send.c",
        "src/server/sv_user.c",
        "src/server/sv_world.c"
    )

    set_default(true)

    add_deps("common")
    add_deps("baseh2q", {inherit = false})

    add_packages("libcurl", "libsdl", "openal-soft")

    if is_plat("windows") then
        add_files("src/backends/windows/icon.rc")
        add_ldflags("-subsystem:console", {force = true})
    end

    after_build(function (target)
        os.cp(path.absolute("baseh2q"), target:targetdir())
    end)

target("q2ded")
    set_kind("binary")

    add_headerfiles("src/server/header/*.h")
    add_files(
        "src/server/sv_cmd.c",
        "src/server/sv_conless.c",
        "src/server/sv_entities.c",
        "src/server/sv_game.c",
        "src/server/sv_init.c",
        "src/server/sv_main.c",
        "src/server/sv_save.c",
        "src/server/sv_send.c",
        "src/server/sv_user.c",
        "src/server/sv_world.c"
    )

    add_defines("DEDICATED_ONLY")

    add_deps("common_ded")
    add_deps("baseh2q", {inherit = false})

    add_packages("libcurl")

    if is_plat("windows") then
        add_files("src/backends/windows/icon.rc")
        add_ldflags("-subsystem:console", {force = true})
    end

target("ref_gl3")
    set_kind("shared")

    add_headerfiles(
        "src/client/refresh/constants/*.h",
        "src/client/refresh/files/*.h",
        "src/client/refresh/gl3/header/*.h"
    )
    add_files(
        "src/client/refresh/gl3/glad/src/glad.c",
        "src/client/refresh/gl3/gl3_draw.c",
        "src/client/refresh/gl3/gl3_image.c",
        "src/client/refresh/gl3/gl3_light.c",
        "src/client/refresh/gl3/gl3_lightmap.c",
        "src/client/refresh/gl3/gl3_main.c",
        "src/client/refresh/gl3/gl3_mesh.c",
        "src/client/refresh/gl3/gl3_misc.c",
        "src/client/refresh/gl3/gl3_model.c",
        "src/client/refresh/gl3/gl3_sdl.c",
        "src/client/refresh/gl3/gl3_surf.c",
        "src/client/refresh/gl3/gl3_warp.c",
        "src/client/refresh/gl3/gl3_shaders.c",
        "src/client/refresh/files/surf.c",
        "src/client/refresh/files/models.c",
        "src/client/refresh/files/pcx.c",
        "src/client/refresh/files/stb.c",
        "src/client/refresh/files/wal.c",
        "src/client/refresh/files/pvs.c"
    )

    set_prefixname("")

    add_includedirs("src/client/refresh/gl3/glad/include")

    add_deps("common")

    add_packages("libsdl")

target("ref_soft")
    set_kind("shared")

    add_headerfiles(
        "src/client/refresh/constants/*.h",
        "src/client/refresh/files/*.h",
        "src/client/refresh/soft/header/*.h"
    )
    add_files(
        "src/client/refresh/soft/sw_aclip.c",
        "src/client/refresh/soft/sw_alias.c",
        "src/client/refresh/soft/sw_bsp.c",
        "src/client/refresh/soft/sw_draw.c",
        "src/client/refresh/soft/sw_edge.c",
        "src/client/refresh/soft/sw_image.c",
        "src/client/refresh/soft/sw_light.c",
        "src/client/refresh/soft/sw_main.c",
        "src/client/refresh/soft/sw_misc.c",
        "src/client/refresh/soft/sw_model.c",
        "src/client/refresh/soft/sw_part.c",
        "src/client/refresh/soft/sw_poly.c",
        "src/client/refresh/soft/sw_polyset.c",
        "src/client/refresh/soft/sw_rast.c",
        "src/client/refresh/soft/sw_scan.c",
        "src/client/refresh/soft/sw_sprite.c",
        "src/client/refresh/soft/sw_surf.c",
        "src/client/refresh/files/surf.c",
        "src/client/refresh/files/models.c",
        "src/client/refresh/files/pcx.c",
        "src/client/refresh/files/stb.c",
        "src/client/refresh/files/wal.c",
        "src/client/refresh/files/pvs.c"
    )

    set_prefixname("")

    add_deps("common")

    add_packages("libsdl")

target("baseh2q")
    set_kind("shared")

    add_headerfiles("src/game/**.h")
    add_files(
        "src/game/g_ai.c",
        "src/game/g_chase.c",
        "src/game/g_cmds.c",
        "src/game/g_combat.c",
        "src/game/g_func.c",
        "src/game/g_items.c",
        "src/game/g_main.c",
        "src/game/g_misc.c",
        "src/game/g_monster.c",
        "src/game/g_phys.c",
        "src/game/g_spawn.c",
        "src/game/g_svcmds.c",
        "src/game/g_target.c",
        "src/game/g_trigger.c",
        "src/game/g_turret.c",
        "src/game/g_utils.c",
        "src/game/g_weapon.c",
        "src/game/monster/berserker/berserker.c",
        "src/game/monster/boss2/boss2.c",
        "src/game/monster/boss3/boss3.c",
        "src/game/monster/boss3/boss31.c",
        "src/game/monster/boss3/boss32.c",
        "src/game/monster/brain/brain.c",
        "src/game/monster/chick/chick.c",
        "src/game/monster/flipper/flipper.c",
        "src/game/monster/float/float.c",
        "src/game/monster/flyer/flyer.c",
        "src/game/monster/gladiator/gladiator.c",
        "src/game/monster/gunner/gunner.c",
        "src/game/monster/hover/hover.c",
        "src/game/monster/infantry/infantry.c",
        "src/game/monster/insane/insane.c",
        "src/game/monster/medic/medic.c",
        "src/game/monster/misc/move.c",
        "src/game/monster/mutant/mutant.c",
        "src/game/monster/parasite/parasite.c",
        "src/game/monster/soldier/soldier.c",
        "src/game/monster/supertank/supertank.c",
        "src/game/monster/tank/tank.c",
        "src/game/player/client.c",
        "src/game/player/hud.c",
        "src/game/player/trail.c",
        "src/game/player/view.c",
        "src/game/player/weapon.c",
        "src/game/savegame/savegame.c"
    )

    set_prefixname("")

    add_deps("common")

    add_packages("libcurl")

    after_build(function (target)
        local extension = ""
        if is_plat("windows") then
            extension = ".dll"
        else
            extension = ".so"
        end
        if not os.exists(path.join(target:targetdir(), "baseh2q")) then
            os.mkdir(path.join(target:targetdir(), "baseh2q"))
        end
        os.cp(target:targetfile(), path.join(target:targetdir(), "baseh2q", "game" .. extension))
    end)
