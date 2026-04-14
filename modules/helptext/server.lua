-- Server-side helptext relay.
-- Triggers client events so server code can show/hide helptext on a player.

olink._register('helptext', {
    ---@param src number
    ---@param message string
    ---@param position string|nil
    Show = function(src, message, position)
        TriggerClientEvent('o-link:client:helptextShow', src, message, position)
    end,

    ---@param src number
    Hide = function(src)
        TriggerClientEvent('o-link:client:helptextHide', src)
    end,
})
