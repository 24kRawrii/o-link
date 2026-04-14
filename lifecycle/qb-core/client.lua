if not olink._guardImpl('Framework', 'qb-core', 'qb-core') then return end
if not olink._hasOverride('Framework') and GetResourceState('qbx_core') == 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1500)
    TriggerEvent('olink:client:playerReady')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerEvent('olink:client:playerUnload')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobData)
    TriggerEvent('olink:client:jobChanged', jobData)
end)

-- Handle resource restart: if player is already loaded, fire the ready event
CreateThread(function()
    Wait(1000)
    local playerData = QBCore.Functions.GetPlayerData()
    if playerData and playerData.citizenid then
        TriggerEvent('olink:client:playerReady')
    end
end)

return true
