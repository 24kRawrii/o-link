if GetResourceState('es_extended') == 'missing' then return end
if GetResourceState('oxide-core') == 'started' then return end
if GetResourceState('qb-core') == 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

-- ESX has no native gang system — stub implementation
olink._register('gang', {
    Get = function() return nil end,
})
