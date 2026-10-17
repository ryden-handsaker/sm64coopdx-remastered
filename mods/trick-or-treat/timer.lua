hook_event(HOOK_UPDATE, function()
    if not network_is_server() then return end
    if (gGlobalSyncTable.gameState == DEATHRUN_INGAME or gGlobalSyncTable.gameState == DEATHRUN_STARTING) and gGlobalSyncTable.roundTimer > 0 then
        gGlobalSyncTable.roundTimer = gGlobalSyncTable.roundTimer - 1
        if gGlobalSyncTable.roundTimer == 0 then
            if gGlobalSyncTable.gameState == DEATHRUN_STARTING then
                gGlobalSyncTable.gameState = DEATHRUN_INGAME
                gGlobalSyncTable.roundTimer = 30 * 60
            else
                -- TODO: game ends
            end
        end
    end
end)