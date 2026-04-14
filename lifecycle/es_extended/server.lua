if GetResourceState('es_extended') == 'missing' then return end

RegisterNetEvent('esx:playerLoaded', function(src)
    src = src or source
    TriggerEvent('olink:server:playerReady', src)
end)

-- esx:playerLogout fires before the player drops; also handle playerDropped for clean disconnect
RegisterNetEvent('esx:playerLogout', function(src)
    src = src or source
    TriggerEvent('olink:server:playerUnload', src)
end)

RegisterNetEvent('esx:setJob', function(src, jobData)
    if jobData and jobData.name then
        TriggerEvent('olink:server:jobChanged', src, jobData.name)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    TriggerEvent('olink:server:playerUnload', src)
    TriggerEvent('olink:server:playerDropped', src)
end)

return true
