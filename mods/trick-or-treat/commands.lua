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