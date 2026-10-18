hook_chat_command("pos", "- print my position", function()
    local m = gMarioStates[0]
    djui_chat_message_create(string.format("pos: %.0f, %.0f, %.0f  facing: %.0f",
        m.pos.x, m.pos.y, m.pos.z, m.faceAngle.y))
    return true
end)

hook_chat_command("start", "- starts the game", function()
    start_game()
    return true
end)

hook_chat_command("roles", "- role", function()
    for i = 0, MAX_PLAYERS - 1 do
        if gNetworkPlayers[i].connected then
            djui_chat_message_create(gNetworkPlayers[i].name .. ": " .. tostring(gPlayerSyncTable[i].role))
        end
    end
    return true
end)

hook_chat_command("freeze", "- freezes mario", function()
    if gMarioStates[0].freeze == 0 then
        gMarioStates[0].freeze = 1
    else
        gMarioStates[0].freeze = 0
    end
    return true
end)

hook_chat_command("bob", "- goes to bob", function()
    warp_to_level(LEVEL_BOB, 1, 1)
end)

hook_chat_command("platform", "- spawns platform", function()
    create_platform()
    return true;
end)

hook_chat_command("trapplatform", "- triggers trap", function()
    trigger_platform_trap()
    return true
end)

hook_chat_command("tp", "- tps player to specified coordinates", function(msg)
    local mario = gMarioStates[0]
    local positions = split(msg, ",")
    local x = tonumber(positions[1])
    local y = tonumber(positions[2])
    local z = tonumber(positions[3])
    vec3f_set(mario.pos, x, y, z)
    vec3f_set(mario.vel, 0, 0, 0)
    mario.forwardVel = 0
    mario.faceAngle.y = 0
    set_mario_action(mario, ACT_FREEFALL, 0)
    return true
end)
