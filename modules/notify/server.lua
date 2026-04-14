-- Server-side notify relay: fires a client event that the client notify module listens to.
local pendingConfirms = {}

olink._register('notify', {
    ---@param src number
    ---@param message string
    ---@param notifType string|nil
    ---@param duration number|nil
    Send = function(src, message, notifType, duration)
        TriggerClientEvent('o-link:client:notify', src, message, notifType, duration)
    end,

    ---@param src number
    ---@param options table { title?, message?, timeout?, acceptLabel?, declineLabel? }
    ---@param callback function(accepted: boolean)
    Confirm = function(src, options, callback)
        local confirmId = ('%x%x'):format(math.random(0, 0x7FFFFFFF), math.random(0, 0x7FFFFFFF))
        pendingConfirms[src] = { id = confirmId, callback = callback }
        TriggerClientEvent('o-link:client:confirm', src, confirmId, options)
    end,
})

RegisterNetEvent('o-link:server:confirmResponse', function(confirmId, accepted)
    local src = source
    local pending = pendingConfirms[src]
    if pending and pending.id == confirmId then
        if pending.callback then pending.callback(accepted) end
        pendingConfirms[src] = nil
    end
end)
