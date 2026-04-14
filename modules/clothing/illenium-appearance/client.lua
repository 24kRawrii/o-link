if not olink._guardImpl('Clothing', 'illenium-appearance', 'illenium-appearance') then return end
if not olink._hasOverride('Clothing') and GetResourceState('rcore_clothing') == 'started' then return end
if not olink._hasOverride('Clothing') and GetResourceState('17mov_CharacterSystem') == 'started' then return end

olink._register('clothing', {
    ---@return string
    GetResourceName = function()
        return 'illenium-appearance'
    end,

    OpenMenu = function()
        TriggerEvent('qb-clothing:client:openMenu')
    end,
})

RegisterNetEvent('o-link:client:clothing:setAppearance', function(data)
    TriggerEvent('o-link:clothing:applyAppearance', data)
end)
