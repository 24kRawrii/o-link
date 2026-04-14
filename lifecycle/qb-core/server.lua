if not olink._guardImpl('Framework', 'qb-core', 'qb-core') then return end
if not olink._hasOverride('Framework') and GetResourceState('qbx_core') == 'started' then return end

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
