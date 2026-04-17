if not olink._guardImpl('ProgressBar', 'esx_progressbar', 'esx_progressbar') then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('oxide-progressbar') == 'started' then return end
if not olink._hasOverride('ProgressBar') and GetResourceState('progressbar') == 'started' then return end

olink._register('progressbar', {
    ---@param options table { duration, label, canCancel?, disable?: { move, car, combat, mouse }, anim?: { dict, clip, flag } }
    ---@param callback function|nil
    ---@return boolean
    Open = function(options, callback)
        if not options then return false end

        local esxOptions = {}

        if options.disable and options.disable.move then
            esxOptions.FreezePlayer = true
        end

        if options.anim then
            if options.anim.scenario then
                esxOptions.animation = {
                    type     = 'Scenario',
                    Scenario = options.anim.scenario,
                }
            elseif options.anim.dict then
                esxOptions.animation = {
                    type = 'anim',
                    dict = options.anim.dict,
                    lib  = options.anim.clip,
                }
            end
        end

        local prom = promise.new()

        esxOptions.onFinish = function()
            if callback then callback(true) end
            prom:resolve(true)
        end

        if options.canCancel then
            esxOptions.onCancel = function()
                if callback then callback(false) end
                prom:resolve(false)
            end
        end

        local started = exports['esx_progressbar']:Progressbar(
            options.label or '',
            options.duration or 5000,
            esxOptions
        )

        if started == false then
            if callback then callback(false) end
            return false
        end

        return Citizen.Await(prom)
    end,
})
