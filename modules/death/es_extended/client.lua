if not olink._guardImpl('Death', 'es_extended', 'es_extended') then return end
if not olink._hasOverride('Death') and GetResourceState('oxide-death') == 'started' then return end

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
