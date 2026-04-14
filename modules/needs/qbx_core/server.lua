if GetResourceState('qbx_core') == 'missing' then return end
if GetResourceState('oxide-needs') == 'started' then return end

local function clamp(v) return math.max(0, math.min(100, v)) end

olink._register('needs', {
    ---@param src number
    ---@param needType string 'hunger'|'thirst'|'stress'
    ---@return number|nil
    GetNeed = function(src, needType)
        local p = exports.qbx_core:GetPlayer(src)
        if not p then return nil end
        return p.PlayerData.metadata[needType]
    end,

    ---@param src number
    ---@param needType string
    ---@param value number 0-100
    ---@return boolean
    SetNeed = function(src, needType, value)
        local p = exports.qbx_core:GetPlayer(src)
        if not p then return false end
        p.Functions.SetMetaData(needType, clamp(value))
        return true
    end,

    ---@param src number
    ---@param needType string
    ---@param amount number
    ---@return boolean
    ModifyNeed = function(src, needType, amount)
        local p = exports.qbx_core:GetPlayer(src)
        if not p then return false end
        local current = p.PlayerData.metadata[needType] or 0
        p.Functions.SetMetaData(needType, clamp(current + amount))
        return true
    end,
})
