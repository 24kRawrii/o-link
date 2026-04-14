if not olink._guardImpl('Death', 'oxide-death', 'oxide-death') then return end

olink._register('death', {
    ---@param src number
    ---@return boolean
    IsPlayerDowned = function(src)
        return exports['oxide-death']:IsPlayerDowned(src) == true
    end,

    ---@param src number
    ---@return boolean
    IsPlayerDead = function(src)
        return exports['oxide-death']:IsPlayerDead(src) == true
    end,

    ---@param src number
    ---@return table|nil
    GetDeathState = function(src)
        return exports['oxide-death']:GetDeathState(src)
    end,

    ---@param src number
    ---@param reviverSrc number|nil
    ---@return boolean
    RevivePlayer = function(src, reviverSrc)
        return exports['oxide-death']:RevivePlayer(src, reviverSrc) == true
    end,

    ---@param src number
    ---@param cause string|nil
    ---@return boolean
    KillPlayer = function(src, cause)
        return exports['oxide-death']:KillPlayer(src, cause) == true
    end,

    ---@param src number
    ---@param coords vector4|nil
    ---@return boolean
    RespawnPlayer = function(src, coords)
        return exports['oxide-death']:RespawnPlayer(src, coords) == true
    end,

    ---@param src number
    ---@param cause string|nil
    ---@param coords vector3|nil
    ---@param heading number|nil
    ---@return boolean
    DownPlayer = function(src, cause, coords, heading)
        return exports['oxide-death']:DownPlayer(src, cause, coords, heading) == true
    end,
})
