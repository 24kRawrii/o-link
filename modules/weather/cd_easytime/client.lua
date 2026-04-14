if not olink._guardImpl('Weather', 'cd_easytime', 'cd_easytime') then return end
if not olink._hasOverride('Weather') and GetResourceState('oxide-weather') == 'started' then return end

olink._register('weather', {
    ---@return string
    GetResourceName = function()
        return 'cd_easytime'
    end,

    ---@param toggle boolean
    ToggleSync = function(toggle)
        TriggerEvent('cd_easytime:PauseSync', toggle)
    end,

    ---@return string
    GetWeather = function()
        return 'CLEAR'
    end,

    ---@return table { hour: number, minute: number }
    GetTime = function()
        return { hour = GetClockHours(), minute = GetClockMinutes() }
    end,
})
