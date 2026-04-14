if not olink._guardImpl('Weather', 'night_natural_disasters', 'night_natural_disasters') then return end
if not olink._hasOverride('Weather') and GetResourceState('oxide-weather') == 'started' then return end

local weatherNames = {
    [`EXTRASUNNY`] = 'EXTRASUNNY',
    [`CLEAR`] = 'CLEAR',
    [`NEUTRAL`] = 'NEUTRAL',
    [`SMOG`] = 'SMOG',
    [`FOGGY`] = 'FOGGY',
    [`OVERCAST`] = 'OVERCAST',
    [`CLOUDS`] = 'CLOUDS',
    [`CLEARING`] = 'CLEARING',
    [`RAIN`] = 'RAIN',
    [`THUNDER`] = 'THUNDER',
    [`SNOW`] = 'SNOW',
    [`BLIZZARD`] = 'BLIZZARD',
    [`SNOWLIGHT`] = 'SNOWLIGHT',
    [`XMAS`] = 'XMAS',
    [`HALLOWEEN`] = 'HALLOWEEN',
}

olink._register('weather', {
    ---@return string
    GetResourceName = function()
        return 'night_natural_disasters'
    end,

    ---@param toggle boolean
    ToggleSync = function(toggle)
        exports['night_natural_disasters']:PauseSynchronization(not toggle)
    end,

    ---@return string
    GetWeather = function()
        return weatherNames[GetPrevWeatherType()] or 'CLEAR'
    end,

    ---@return table { hour: number, minute: number }
    GetTime = function()
        return { hour = GetClockHours(), minute = GetClockMinutes() }
    end,
})
