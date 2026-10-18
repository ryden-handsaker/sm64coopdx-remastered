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
    platform.oPosY = 400
end

local thwomp_trap_should_drop = false

local function thwomp_loop(o)
    if not network_is_server() then return end
    
    if o.oAction == 2 and not thwomp_trap_should_drop then
        o.oAction = 1
        o.oTimer = 0
        return
    end

    if thwomp_trap_should_drop and o.oAction == 1 then
        o.oAction = 2
        o.oTimer = 0
    end

    if o.oAction == 3 then
        thwomp_trap_should_drop = false
    end
end

hook_chat_command("thwomp", "- thomb", function()
    spawn_sync_object(id_bhvThwomp, E_MODEL_THWOMP, -5500, 100, 5986, nil)
end)

hook_chat_command("trapthwomp", "- drop the thwomps", function()
    if not network_is_server() then return false end
    thwomp_trap_should_drop = true
    return true
end)

hook_behavior(id_bhvThwomp, OBJ_LIST_SURFACE, false, nil, thwomp_loop)