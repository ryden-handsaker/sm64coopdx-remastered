hook_event(HOOK_ON_HUD_RENDER, function()
    if gGlobalSyncTable.gameState == DEATHRUN_NONE then return end

    local frames = gGlobalSyncTable.roundTimer
    local totalSeconds = math.ceil(frames / 30)
    local minutes = math.floor(totalSeconds / 60)
    local seconds = totalSeconds % 60
    local text = string.format("%d:%02d", minutes, seconds)

    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(FONT_NORMAL)

    local scale = 2
    local width = djui_hud_measure_text(text) * scale
    local x = (djui_hud_get_screen_width() - width) / 2
    local y = 20

    if totalSeconds <= 10 then
        djui_hud_set_color(255, 60, 60, 255)
    else
        djui_hud_set_color(255, 255, 255, 255)
    end
    djui_hud_print_text(text, x, y, scale)
end)