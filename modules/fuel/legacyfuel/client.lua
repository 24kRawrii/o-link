if not olink._guardImpl('Fuel', 'legacyfuel', 'LegacyFuel') then return end
if not olink._hasOverride('Fuel') and GetResourceState('oxide-vehicles') == 'started' then return end
if not olink._hasOverride('Fuel') and GetResourceState('qb-fuel') == 'started' then return end

olink._register('fuel', {
    ---@return string
    GetResourceName = function()
        return 'LegacyFuel'
    end,

    ---@param vehicle number
    ---@return number
    GetFuel = function(vehicle)
        if not DoesEntityExist(vehicle) then return 0.0 end
        return exports['LegacyFuel']:GetFuel(vehicle)
    end,

    ---@param vehicle number
    ---@param fuel number
    ---@param type? string
    SetFuel = function(vehicle, fuel, type)
        if not DoesEntityExist(vehicle) then return end
        exports['LegacyFuel']:SetFuel(vehicle, fuel)
    end,
})
