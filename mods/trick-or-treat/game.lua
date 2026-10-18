function assign_roles()
    if not network_is_server() then return end

    local players = {}
    
    for i = 0, MAX_PLAYERS - 1 do
        if gNetworkPlayers[i].connected then
            gPlayerSyncTable[i].role = ROLE_RUNNER
            table.insert(players, i)
        end
    end

    local trapper = players[math.random(#players)]

    gPlayerSyncTable[trapper].role = ROLE_TRAPPER
end

function go_to_lobby(m)
    LOBBY_X = 0
    LOBBY_Y = 2000
    LOBBY_Z = -1710
    vec3f_set(m.pos, LOBBY_X, LOBBY_Y, LOBBY_Z)
    vec3f_set(m.vel, 0, 0, 0)
    m.forwardVel = 0
    m.faceAngle.y = 0
    set_mario_action(m, ACT_FREEFALL, 0)
end

function start_game()
    if not network_is_server() then return end

    gGlobalSyncTable.gameState = DEATHRUN_STARTING

    djui_popup_create_global("Starting a new game!", 1)

    assign_roles()

    gGlobalSyncTable.roundTimer = 120

    -- teleport players to a location
    
    
    return true
end