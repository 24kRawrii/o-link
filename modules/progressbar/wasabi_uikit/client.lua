if not olink._guardImpl('ProgressBar', 'wasabi_uikit', 'wasabi_uikit') then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('oxide-progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('esx_progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('keep-progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('lation_ui') == 'started' then return end

olink._register('progressbar', {
    ---@param options table { duration, label, canCancel?, style?: string, disable?: { move, car, combat, mouse }, anim?: { dict, clip, flag } }
    ---@param callback function|nil
    ---@return boolean
    Open = function(options, callback)
        local style = options.style or 'bar'
        local success = exports.wasabi_uikit:ProgressBar(options, style)
        if callback then callback(success) end
        return success
    end,
})
