if GetResourceState('es_extended') == 'missing' then return end
if GetResourceState('oxide-death') == 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

olink._register('death', {
    ---@param src number
    ---@return boolean
    IsPlayerDowned = function(src)
        -- ESX has no native downed/laststand concept — only dead or alive
        return false
    end,

    ---@param src number
    ---@return boolean
    IsPlayerDead = function(src)
        local p = ESX.GetPlayerFromId(src)
        if not p then return false end
        return p.get('is_dead') == true
    end,

    ---@param src number
    ---@return table|nil
    GetDeathState = function(src)
        local p = ESX.GetPlayerFromId(src)
        if not p then return nil end
        local state = p.get('is_dead') and 'dead' or 'alive'
        return { state = state }
    end,

    ---@param src number
    ---@param reviverSrc number|nil
    ---@return boolean
    RevivePlayer = function(src, reviverSrc)
        TriggerEvent('esx_ambulancejob:revive', src)
        return true
    end,

    ---@param src number
    ---@param cause string|nil
    ---@return boolean
    KillPlayer = function(src, cause)
        TriggerClientEvent('esx:killPlayer', src)
        return true
    end,

    ---@param src number
    ---@param coords vector4|nil
    ---@return boolean
    RespawnPlayer = function(src, coords)
        if coords then
            SetEntityCoords(GetPlayerPed(src), coords.x, coords.y, coords.z)
            if coords.w then SetEntityHeading(GetPlayerPed(src), coords.w) end
        end
        TriggerEvent('esx_ambulancejob:revive', src)
        return true
    end,

    ---@param src number
    ---@param cause string|nil
    ---@param coords vector3|nil
    ---@param heading number|nil
    ---@return boolean
    DownPlayer = function(src, cause, coords, heading)
        -- ESX has no native downed/laststand — kill instead
        TriggerClientEvent('esx:killPlayer', src)
        return true
    end,
})
