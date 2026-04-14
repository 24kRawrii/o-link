if GetResourceState('qbx_core') == 'missing' then return end
if GetResourceState('oxide-death') == 'started' then return end

olink._register('death', {
    ---@return boolean
    IsPlayerDowned = function()
        local data = exports.qbx_core:GetPlayerData()
        if not data or not data.metadata then return false end
        return data.metadata.inlaststand == true
    end,

    ---@return boolean
    IsPlayerDead = function()
        local data = exports.qbx_core:GetPlayerData()
        if not data or not data.metadata then return false end
        return data.metadata.isdead == true
    end,

    ---@return table|nil
    GetDeathState = function()
        local data = exports.qbx_core:GetPlayerData()
        if not data or not data.metadata then return nil end
        local state = 'alive'
        if data.metadata.isdead then state = 'dead'
        elseif data.metadata.inlaststand then state = 'downed' end
        return { state = state }
    end,
})
