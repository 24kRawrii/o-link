if GetResourceState('oxide-death') == 'missing' then return end

olink._register('death', {
    ---@return boolean
    IsPlayerDowned = function()
        return exports['oxide-death']:IsLocalPlayerDowned() == true
    end,

    ---@return boolean
    IsPlayerDead = function()
        return exports['oxide-death']:IsLocalPlayerDead() == true
    end,

    ---@return table|nil
    GetDeathState = function()
        return exports['oxide-death']:GetLocalDeathState()
    end,
})
