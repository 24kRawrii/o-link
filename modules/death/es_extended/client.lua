if GetResourceState('es_extended') == 'missing' then return end
if GetResourceState('oxide-death') == 'started' then return end

olink._register('death', {
    ---@return boolean
    IsPlayerDowned = function()
        -- ESX has no native downed/laststand concept
        return false
    end,

    ---@return boolean
    IsPlayerDead = function()
        -- ESX tracks death via player statebag
        return LocalPlayer.state.isDead == true
    end,

    ---@return table|nil
    GetDeathState = function()
        local state = LocalPlayer.state.isDead and 'dead' or 'alive'
        return { state = state }
    end,
})
