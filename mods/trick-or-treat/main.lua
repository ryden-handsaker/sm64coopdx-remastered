-- name: Trick or Troick
-- description: Tiki wa hackathon
-- pausable: false

ROLE_NONE    = 0
ROLE_RUNNER  = 1
ROLE_TRAPPER = 2

DEATHRUN_NONE = 0
DEATHRUN_STARTING = 1
DEATHRUN_INGAME = 2

if network_is_server() then
    gGlobalSyncTable.gameState = DEATHRUN_NONE
    gGlobalSyncTable.roundTimer = 0
end

local should_teleport_to_lobby = false



local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if gGlobalSyncTable.gameState == DEATHRUN_STARTING then
        m.freeze = 1;
    else
        m.freeze = 0;
    end
end

local function on_mario_interact(m, obj, interact_type, interact_value)
    if m.playerIndex ~= 0 then return end

    local id = get_id_from_behavior(obj.behavior)
    if id == id_bhvBreakableBox then
        local punching = (m.action == ACT_PUNCHING or m.action == ACT_MOVE_PUNCHING)
        if punching then
            spawn_goombas(-5160, 83, 5986, 100)
        end
    elseif id == id_bhvExclamationBox then
        djui_chat_message_create("hit exclamation")
    end
end

local function respawn_player(m)
    vec3f_set(m.pos, 0, 2000, -1710)
    m.healCounter = 0
    m.hurtCounter = 0
    m.health = 0x880
end

local function on_mario_update(m)
    if m.playerIndex ~= 0 then return end  -- only the local player
    if m.controller.buttonPressed & X_BUTTON ~= 0 then
        local num = math.random(0, 1)
        djui_chat_message_create("Hello.")
        djui_chat_message_create(tostring(num))
    end
    if should_teleport_to_lobby then
        go_to_lobby(m)
        should_teleport_to_lobby = false
    end

    if m.hurtCounter > 0 then
        respawn_player(m)
    end
end

local function on_mario_death(m)
    respawn_player(m)
    return false
end

hook_event(HOOK_ON_INTERACT, on_mario_interact)
hook_event(HOOK_ON_DEATH, on_mario_death)
hook_event(HOOK_MARIO_UPDATE, on_mario_update)
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_PLAYER_CONNECTED, function(m)
    gPlayerSyncTable[m.playerIndex].role = ROLE_NONE
    if m.playerIndex == 0 then
        should_teleport_to_lobby = true
    end
end)

hook_event(HOOK_ON_PLAYER_DISCONNECTED, function(m)
    if gPlayerSyncTable[m.playerIndex].role == ROLE_TRAPPER then
        -- TODO: end round
    end
end)
