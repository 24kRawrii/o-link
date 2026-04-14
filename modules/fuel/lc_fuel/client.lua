if not olink._guardImpl('Fuel', 'lc_fuel', 'lc_fuel') then return end
if not olink._hasOverride('Fuel') and GetResourceState('oxide-vehicles') == 'started' then return end

olink._register('fuel', {
    ---@return string
    GetResourceName = function()
        return 'lc_fuel'
    end,

    ---@param vehicle number
    ---@return number
    GetFuel = function(vehicle)
        if not DoesEntityExist(vehicle) then return 0.0 end
        return exports['lc_fuel']:GetFuel(vehicle)
    end,

    ---@param vehicle number
    ---@param fuel number
    ---@param type? string
    SetFuel = function(vehicle, fuel, type)
        if not DoesEntityExist(vehicle) then return end
        exports['lc_fuel']:SetFuel(vehicle, fuel)
    end,
})
