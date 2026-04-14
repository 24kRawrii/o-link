if not olink._guardImpl('Notify', 'wasabi_notify', 'wasabi_notify') then return end
if not olink._hasOverride('Notify') and GetResourceState('oxide-notify') == 'started' then return end

local mod = {
    ---@param message string
    ---@param notifType string|nil
    ---@param duration number|nil
    Send = function(message, notifType, duration)
        duration = duration or 3000
        notifType = notifType or 'info'
        exports.wasabi_notify:notify(notifType, message, duration, notifType)
    end,
}

RegisterNetEvent('o-link:client:notify', function(message, notifType, duration)
    mod.Send(message, notifType, duration)
end)

olink._register('notify', mod)
