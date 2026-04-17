if not olink._guardImpl('ProgressBar', 'keep-progressbar', 'keep-progressbar') then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('oxide-progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('esx_progressbar') == 'started' then return end

olink._register('progressbar', {
    ---@param options table { duration, label, canCancel?, disable?: { move, car, combat, mouse }, anim?: { dict, clip, flag } }
    ---@param callback function|nil
    ---@return boolean
    Open = function(options, callback)
        local success = exports['keep-progressbar']:ox_lib_progressBar(options)
        if callback then callback(success) end
        return success
    end,
})
