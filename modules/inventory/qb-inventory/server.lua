if not olink._guardImpl('Inventory', 'qb-inventory', 'qb-inventory') then return end
if not olink._hasOverride('Inventory') and GetResourceState('oxide-inventory') == 'started' then return end

local qbInventory = exports['qb-inventory']
local QBCore = exports['qb-core']:GetCoreObject()

local stashes = {}

---Detect qb-inventory v2+ by checking the version metadata
---@return boolean
local function isV2()
    local v = GetResourceMetadata('qb-inventory', 'version', 0)
    return v ~= nil and tonumber(string.sub(v, 1, 1)) >= 2
end

local v2 = isV2()

olink._register('inventory', {
    ---@param src number
    ---@param item string
    ---@return number
    GetItemCount = function(src, item)
        local player = QBCore.Functions.GetPlayer(src)
        if not player then return 0 end
        local items = player.PlayerData.items
        if not items then return 0 end
        local total = 0
        for _, v in pairs(items) do
            if v and v.name == item then
                total = total + (v.amount or 0)
            end
        end
        return total
    end,

    ---@param src number
    ---@param item string
    ---@param count number|nil
    ---@return boolean
    HasItem = function(src, item, count)
        local player = QBCore.Functions.GetPlayer(src)
        if not player then return false end
        local items = player.PlayerData.items
        if not items then return false end
        local total = 0
        for _, v in pairs(items) do
            if v and v.name == item then
                total = total + (v.amount or 0)
            end
        end
        return total >= (count or 1)
    end,

    ---@param src number
    ---@param item string
    ---@param count number
    ---@param slot number|nil
    ---@param metadata table|nil
    ---@return boolean
    AddItem = function(src, item, count, slot, metadata)
        if v2 and not qbInventory:CanAddItem(src, item, count) then return false end
        local success = qbInventory:AddItem(src, item, count, slot, metadata, 'o-link')
        return success == true
    end,

    ---@param src number
    ---@param item string
    ---@param count number
    ---@param slot number|nil
    ---@param metadata table|nil
    ---@return boolean
    RemoveItem = function(src, item, count, slot, metadata)
        local success = qbInventory:RemoveItem(src, item, count, slot, 'o-link')
        return success == true
    end,

    ---@param src number
    ---@param slot number
    ---@return table|nil SlotData {name, label, count, slot, weight, metadata}
    GetItemBySlot = function(src, slot)
        local data = qbInventory:GetItemBySlot(src, slot)
        if not data then return nil end
        return {
            name     = data.name,
            label    = data.label or data.name,
            count    = data.amount,
            slot     = data.slot,
            weight   = data.weight,
            metadata = data.info or {},
        }
    end,

    ---@param src number
    ---@return table[] SlotData[]
    GetPlayerInventory = function(src)
        local player = QBCore.Functions.GetPlayer(src)
        if not player then return {} end
        local items = player.PlayerData.items
        if not items then return {} end
        local result = {}
        for _, item in pairs(items) do
            if item and item.name then
                result[#result + 1] = {
                    name     = item.name,
                    label    = item.label or item.name,
                    count    = item.amount,
                    slot     = item.slot,
                    weight   = item.weight,
                    metadata = item.info or {},
                }
            end
        end
        return result
    end,

    ---@param src number
    ---@param targetSrc number
    ---@return boolean
    OpenPlayerInventory = function(src, targetSrc)
        assert(src, 'OpenPlayerInventory: src is required')
        assert(targetSrc, 'OpenPlayerInventory: targetSrc is required')
        qbInventory:OpenInventory(src, targetSrc)
        return true
    end,

    ---@param id string
    ---@param label string
    ---@param slots number
    ---@param weight number
    ---@param owner string|nil
    ---@return boolean
    RegisterStash = function(id, label, slots, weight, owner)
        id = tostring(id)
        if stashes[id] then return true end
        stashes[id] = { label = label, slots = slots, weight = weight, owner = owner }
        if v2 then
            if not qbInventory:GetInventory(id) then
                qbInventory:CreateInventory(id, { label = label, slots = slots, maxweight = weight })
            end
        end
        return true
    end,

    ---@param src number
    ---@param stashId string
    ---@return nil
    OpenStash = function(src, stashId)
        stashId = tostring(stashId)
        if v2 then
            qbInventory:OpenInventory(src, stashId)
        else
            local tbl = stashes[stashId] or {}
            TriggerClientEvent('o-link:inventory:qb:openStash', src, stashId, {
                weight = tbl.weight or 5000,
                slots  = tbl.slots or 20,
            })
        end
    end,

    ---@param item string
    ---@return table {name, label, weight, description}
    GetItemInfo = function(item)
        local data = QBCore.Shared.Items[item]
        if not data then return {} end
        return {
            name = data.name,
            label = data.label,
            weight = data.weight,
            description = data.description,
        }
    end,

    ---@param item string
    ---@return string
    GetImagePath = function(item)
        item = olink._stripExt(item)
        local file = LoadResourceFile('qb-inventory', ('html/images/%s.png'):format(item))
        if file then return ('nui://qb-inventory/html/images/%s.png'):format(item) end
        return ''
    end,

    ---@return table All item definitions
    Items = function()
        return QBCore.Shared.Items or {}
    end,

    ---@param src number
    ---@param item string
    ---@param count number|nil
    ---@return boolean
    CanCarryItem = function(src, item, count)
        if v2 then return qbInventory:CanAddItem(src, item, count or 1) == true end
        return true
    end,

    ---@param id string
    ---@return table[]
    GetStashItems = function(id)
        return {}
    end,

    ---@param id string
    ---@param item string
    ---@param count number
    ---@return boolean
    RemoveStashItem = function(id, item, count)
        return false
    end,

    ---@param id string
    ---@param _type string|nil unused
    ---@return boolean
    ClearStash = function(id, _type)
        return false
    end,

    ---@param identifier string plate or trunk identifier
    ---@param items table[]
    ---@return boolean
    AddTrunkItems = function(identifier, items)
        return false
    end,

    ---@param oldPlate string
    ---@param newPlate string
    ---@return boolean
    UpdatePlate = function(oldPlate, newPlate)
        return false
    end,

    ---@param src number
    ---@param shopTitle string
    OpenShop = function(src, shopTitle)
    end,

    ---@param shopTitle string
    ---@param shopInventory table
    ---@param shopCoords table|nil
    ---@param shopGroups table|nil
    RegisterShop = function(shopTitle, shopInventory, shopCoords, shopGroups)
    end,
})
