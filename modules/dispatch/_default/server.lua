-- Default dispatch fallback.
-- Only loads when no dedicated dispatch resource is running.
-- Relays alerts to job members via notifications.

if GetResourceState('ps-dispatch') == 'started' then return end
if GetResourceState('cd_dispatch') == 'started' then return end
if GetResourceState('lb-tablet') == 'started' then return end
if GetResourceState('bub-mdt') == 'started' then return end
if GetResourceState('emergencydispatch') == 'started' then return end
if GetResourceState('qs_dispatch') == 'started' then return end
if GetResourceState('tk_dispatch') == 'started' then return end
if GetResourceState('fd_dispatch') == 'started' then return end
if GetResourceState('kartik-mdt') == 'started' then return end
if GetResourceState('linden_outlawalert') == 'started' then return end
if GetResourceState('origen_police') == 'started' then return end
if GetResourceState('piotreq_gpt') == 'started' then return end
if GetResourceState('redutzu-mdt') == 'started' then return end
if GetResourceState('wasabi_mdt') == 'started' then return end

olink._register('dispatch', {
    GetResourceName = function() return '_default' end,
})

local lastAlert = {}

RegisterNetEvent('o-link:dispatch:default:sendAlert', function(data)
    local src = source
    if not src or not GetPlayerPing(src) then return end

    local now = GetGameTimer()
    if lastAlert[src] and (now - lastAlert[src]) < 5000 then return end
    lastAlert[src] = now

    -- Inject server-authoritative coords
    local ped = GetPlayerPed(src)
    if ped and ped > 0 then
        data.coords = GetEntityCoords(ped)
    end

    local jobs = type(data.jobs) == 'table' and data.jobs or { data.jobs or 'police' }
    for i = 1, math.min(#jobs, 5) do
        local jobName = jobs[i]
        if type(jobName) == 'string' and olink.job then
            local members = olink.job.GetPlayersWithJob(jobName)
            for _, target in ipairs(members or {}) do
                TriggerClientEvent('o-link:dispatch:default:alert', target, data)
            end
        end
    end
end)

AddEventHandler('playerDropped', function()
    lastAlert[source] = nil
end)
