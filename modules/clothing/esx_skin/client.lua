if not olink._guardImpl('Clothing', 'esx_skin', 'esx_skin') then return end
if not olink._hasOverride('Clothing') and GetResourceState('rcore_clothing') == 'started' then return end
if not olink._hasOverride('Clothing') and GetResourceState('17mov_CharacterSystem') == 'started' then return end

olink._register('clothing', {
    ---@return string
    GetResourceName = function()
        return 'esx_skin'
    end,

    OpenMenu = function()
        TriggerEvent('esx_skin:openMenu', function() end, function() end, true)
    end,
})

RegisterNetEvent('o-link:client:clothing:setAppearance', function(data)
    -- Forward to any appearance apply handler listening on this resource
    TriggerEvent('o-link:clothing:applyAppearance', data)
end)
