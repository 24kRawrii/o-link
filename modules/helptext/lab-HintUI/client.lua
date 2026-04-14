if GetResourceState('lab-HintUI') == 'missing' then return end

olink._register('helptext', {
    ---@param message string
    ---@param position string|nil
    Show = function(message, position)
        exports['lab-HintUI']:Show(message, 'Hint Text')
    end,

    Hide = function()
        exports['lab-HintUI']:Hide()
    end,
})

RegisterNetEvent('o-link:client:helptextShow', function(message, position)
    olink.helptext.Show(message, position)
end)

RegisterNetEvent('o-link:client:helptextHide', function()
    olink.helptext.Hide()
end)
