if GetResourceState('oxide-needs') == 'missing' then return end

olink._register('needs', {
    ---@param src number
    ---@param needType string 'hunger'|'thirst'|'stress'
    ---@return number|nil
    GetNeed = function(src, needType)
        return exports['oxide-needs']:GetNeed(src, needType)
    end,

    ---@param src number
    ---@param needType string
    ---@param value number 0-100
    ---@return boolean
    SetNeed = function(src, needType, value)
        return exports['oxide-needs']:SetNeed(src, needType, value) == true
    end,

    ---@param src number
    ---@param needType string
    ---@param amount number positive or negative
    ---@return boolean
    ModifyNeed = function(src, needType, amount)
        return exports['oxide-needs']:ModifyNeed(src, needType, amount) == true
    end,
})
