if not olink._guardImpl('Death', 'qb-core', 'qb-core') then return end
if not olink._hasOverride('Death') and GetResourceState('qbx_core') == 'started' then return end
if not olink._hasOverride('Death') and GetResourceState('oxide-death') == 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

olink._register('death', {
    ---@return boolean
    IsPlayerDowned = function()
        local data = QBCore.Functions.GetPlayerData()
        if not data or not data.metadata then return false end
        return data.metadata.inlaststand == true
    end,

    ---@return boolean
    IsPlayerDead = function()
        local data = QBCore.Functions.GetPlayerData()
        if not data or not data.metadata then return false end
        return data.metadata.isdead == true
    end,

    ---@return table|nil
    GetDeathState = function()
        local data = QBCore.Functions.GetPlayerData()
        if not data or not data.metadata then return nil end
        local state = 'alive'
        if data.metadata.isdead then state = 'dead'
        elseif data.metadata.inlaststand then state = 'downed' end
        return { state = state }
    end,
})
