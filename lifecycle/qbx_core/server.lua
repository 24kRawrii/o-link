if not olink._guardImpl('Framework', 'qbx_core', 'qbx_core') then return end

-- QBX Core fires the same server-side events as QBCore
RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function(src)
    src = src or source
    TriggerEvent('olink:server:playerReady', src)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(src)
    src = src or source
    TriggerEvent('olink:server:playerUnload', src)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(src, jobData)
    src = src or source
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
