if GetResourceState('es_extended') == 'missing' then return end
if GetResourceState('oxide-needs') == 'started' then return end

-- ESX uses esx_status system with range 0-1000000 (client-side events).
-- o-link normalizes to 0-100. ESX has no native stress system.

local ESX = exports['es_extended']:getSharedObject()

local ESX_MAX = 1000000

local function toOlink(esxVal)
    return math.floor(((esxVal or 0) / ESX_MAX) * 100 + 0.5)
end

local function toEsx(olinkVal)
    return math.floor(((olinkVal or 0) / 100) * ESX_MAX + 0.5)
end

local function clamp(v) return math.max(0, math.min(100, v)) end

olink._register('needs', {
    ---@param src number
    ---@param needType string 'hunger'|'thirst'|'stress'
    ---@return number|nil 0-100
    GetNeed = function(src, needType)
        if needType == 'stress' then return 0 end
        local p = ESX.GetPlayerFromId(src)
        if not p then return nil end
        local status = p.get('status')
        if not status then return nil end
        for _, s in ipairs(status) do
            if s.name == needType then
                return toOlink(s.val)
            end
        end
        return nil
    end,

    ---@param src number
    ---@param needType string
    ---@param value number 0-100
    ---@return boolean
    SetNeed = function(src, needType, value)
        if needType == 'stress' then return false end
        TriggerClientEvent('esx_status:set', src, needType, toEsx(clamp(value)))
        return true
    end,

    ---@param src number
    ---@param needType string
    ---@param amount number positive or negative (in 0-100 scale)
    ---@return boolean
    ModifyNeed = function(src, needType, amount)
        if needType == 'stress' then return false end
        if amount >= 0 then
            TriggerClientEvent('esx_status:add', src, needType, toEsx(amount))
        else
            TriggerClientEvent('esx_status:remove', src, needType, toEsx(math.abs(amount)))
        end
        return true
    end,
})
