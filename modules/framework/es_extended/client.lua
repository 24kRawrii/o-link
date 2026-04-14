if not olink._guardImpl('Framework', 'es_extended', 'es_extended') then return end

local ESX = exports['es_extended']:getSharedObject()

olink._register('framework', {
    ---@return string
    GetName = function()
        return 'es_extended'
    end,

    ---@return boolean
    GetIsPlayerLoaded = function()
        return ESX.IsPlayerLoaded()
    end,
})
