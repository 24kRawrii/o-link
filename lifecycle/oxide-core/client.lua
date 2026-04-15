if not olink._guardImpl('Framework', 'oxide-core', 'oxide-core') then return end

AddStateBagChangeHandler('oxide:character', ('player:%s'):format(cache.serverId), function(_, _, value)
    if value ~= nil then
        Wait(500)
        TriggerEvent('olink:client:playerReady')
    else
        TriggerEvent('olink:client:playerUnload')
    end
end)

AddStateBagChangeHandler('oxide:job', ('player:%s'):format(cache.serverId), function(_, _, value)
    if value then
        TriggerEvent('olink:client:jobChanged', {
            name       = value.jobName or 'unemployed',
            label      = value.jobLabel or 'Unemployed',
            grade      = value.gradeName or 'default',
            gradeLabel = value.gradeLabel or 'Default',
            rank       = value.gradeRank or 0,
            isBoss     = value.boss or false,
            onDuty     = value.onDuty or false,
        })
    end
end)

-- Handle resource restart: if player is already loaded, fire the ready event
CreateThread(function()
    Wait(1000)
    if LocalPlayer.state['oxide:character'] ~= nil then
        TriggerEvent('olink:client:playerReady')
    end
end)

return true
