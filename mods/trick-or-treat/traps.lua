traps = {
    { trap = 1, cooldown = 0 },
    { trap = 2, cooldown = 0 }
}

function spawn_goombas(x, y, z, count)
    for i = 1, count do
        spawn_sync_object(id_bhvGoomba, E_MODEL_GOOMBA, x, y, z, function() end)
    end
end

local platform


function create_platform()
    if not network_is_server() then return end

    platform = spawn_sync_object(id_bhvStaticCheckeredPlatform, E_MODEL_CHECKERBOARD_PLATFORM, -5160, 100, 5986, nil)
end

function trigger_platform_trap()
    platform.oPosY = 50
end