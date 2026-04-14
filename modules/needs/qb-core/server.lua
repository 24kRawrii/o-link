if not olink._guardImpl('Needs', 'qb-core', 'qb-core') then return end
if not olink._hasOverride('Needs') and GetResourceState('qbx_core') == 'started' then return end
if not olink._hasOverride('Needs') and GetResourceState('oxide-needs') == 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

local function clamp(v) return math.max(0, math.min(100, v)) end

olink._register('needs', {
    ---@param src number
    ---@param needType string 'hunger'|'thirst'|'stress'
    ---@return number|nil
    GetNeed = function(src, needType)
        local p = QBCore.Functions.GetPlayer(src)
        if not p then return nil end
        return p.PlayerData.metadata[needType]
    end,

    ---@param src number
    ---@param needType string
    ---@param value number 0-100
    ---@return boolean
    SetNeed = function(src, needType, value)
        local p = QBCore.Functions.GetPlayer(src)
        if not p then return false end
        p.Functions.SetMetaData(needType, clamp(value))
        return true
    end,

    ---@param src number
    ---@param needType string
    ---@param amount number
    ---@return boolean
    ModifyNeed = function(src, needType, amount)
        local p = QBCore.Functions.GetPlayer(src)
        if not p then return false end
        local current = p.PlayerData.metadata[needType] or 0
        p.Functions.SetMetaData(needType, clamp(current + amount))
        return true
    end,
})
