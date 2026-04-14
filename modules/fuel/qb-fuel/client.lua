if not olink._guardImpl('Fuel', 'qb-fuel', 'qb-fuel') then return end
if not olink._hasOverride('Fuel') and GetResourceState('oxide-vehicles') == 'started' then return end

olink._register('fuel', {
    ---@return string
    GetResourceName = function()
        return 'qb-fuel'
    end,

    ---@param vehicle number
    ---@return number
    GetFuel = function(vehicle)
        if not DoesEntityExist(vehicle) then return 0.0 end
        return exports['qb-fuel']:GetFuel(vehicle)
    end,

    ---@param vehicle number
    ---@param fuel number
    ---@param type? string
    SetFuel = function(vehicle, fuel, type)
        if not DoesEntityExist(vehicle) then return end
        exports['qb-fuel']:SetFuel(vehicle, fuel)
    end,
})
