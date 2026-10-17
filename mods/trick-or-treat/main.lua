-- name: Trick or Troick
-- description: Tiki wa hackathon
-- pausable: false

local function on_mario_update(m)
    if m.playerIndex ~= 0 then return end  -- only the local player
    if m.controller.buttonPressed & X_BUTTON ~= 0 then
        djui_chat_message_create("Hello from my mod!")
    end
end

hook_event(HOOK_MARIO_UPDATE, on_mario_update)