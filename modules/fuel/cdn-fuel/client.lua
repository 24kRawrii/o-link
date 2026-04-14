if not olink._guardImpl('Fuel', 'cdn-fuel', 'cdn-fuel') then return end
if not olink._hasOverride('Fuel') and GetResourceState('oxide-vehicles') == 'started' then return end

olink._register('fuel', {
    ---@return string
    GetResourceName = function()
        return 'cdn-fuel'
    end,

    ---@param vehicle number
    ---@return number
    GetFuel = function(vehicle)
        if not DoesEntityExist(vehicle) then return 0.0 end
        return exports['cdn-fuel']:GetFuel(vehicle)
    end,

    ---@param vehicle number
    ---@param fuel number
    ---@param type? string
    SetFuel = function(vehicle, fuel, type)
        if not DoesEntityExist(vehicle) then return end
        exports['cdn-fuel']:SetFuel(vehicle, fuel)
    end,
})
