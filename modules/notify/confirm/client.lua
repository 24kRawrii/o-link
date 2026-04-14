-- Client-side confirm dialog handler.
-- Uses ox_lib alertDialog as the universal confirm UI since ox_lib is a mandatory dependency.

RegisterNetEvent('o-link:client:confirm', function(confirmId, options)
    CreateThread(function()
        local result = lib.alertDialog({
            header  = options.title or 'Confirm',
            content = options.message or '',
            centered = true,
            cancel  = true,
            labels  = {
                confirm = options.acceptLabel or 'Accept',
                cancel  = options.declineLabel or 'Decline',
            },
        })
        TriggerServerEvent('o-link:server:confirmResponse', confirmId, result == 'confirm')
    end)
end)
