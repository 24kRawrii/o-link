if GetResourceState('ox_lib') == 'missing' then return end
if GetResourceState('cd_drawtextui') == 'started' then return end
if GetResourceState('jg-textui') == 'started' then return end
if GetResourceState('lab-HintUI') == 'started' then return end
if GetResourceState('lation_ui') == 'started' then return end
if GetResourceState('okokTextUI') == 'started' then return end
if GetResourceState('ZSX_UIV2') == 'started' then return end

olink._register('helptext', {
    ---@param message string
    ---@param position string|nil
    Show = function(message, position)
        lib.showTextUI(message, { position = position })
    end,

    Hide = function()
        lib.hideTextUI()
    end,
})

RegisterNetEvent('o-link:client:helptextShow', function(message, position)
    olink.helptext.Show(message, position)
end)

RegisterNetEvent('o-link:client:helptextHide', function()
    olink.helptext.Hide()
end)
