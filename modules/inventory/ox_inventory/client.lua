if not olink._guardImpl('Inventory', 'ox_inventory', 'ox_inventory') then return end
if not olink._hasOverride('Inventory') and GetResourceState('oxide-inventory') == 'started' then return end
if not olink._hasOverride('Inventory') and GetResourceState('qb-inventory') == 'started' then return end

local ox_inventory = exports.ox_inventory

olink._register('inventory', {
    ---@return table[] SlotData[]
    GetPlayerInventory = function()
        local items = ox_inventory:GetPlayerItems()
        if not items then return {} end
        local result = {}
        for _, item in pairs(items) do
            result[#result + 1] = {
                name     = item.name,
                label    = item.label,
                count    = item.count,
                slot     = item.slot,
                weight   = item.weight,
                metadata = item.metadata or {},
            }
        end
        return result
    end,

    ---@param item string
    ---@return number
    GetItemCount = function(item)
        return ox_inventory:GetItemCount(item, nil, false) or 0
    end,

    ---@param item string
    ---@param count number|nil
    ---@return boolean
    HasItem = function(item, count)
        return (ox_inventory:GetItemCount(item, nil, false) or 0) >= (count or 1)
    end,

    ---@param item string
    ---@return table {name, label, weight, description}
    GetItemInfo = function(item)
        local data = ox_inventory:Items(item)
        if not data then return {} end
        return { name = data.name, label = data.label, weight = data.weight, description = data.description }
    end,

    ---@param item string
    ---@return string
    GetImagePath = function(item)
        item = olink._stripExt(item)
        local file = LoadResourceFile('ox_inventory', ('web/images/%s.png'):format(item))
        if file then return ('nui://ox_inventory/web/images/%s.png'):format(item) end
        return ''
    end,

    ---@return table All item definitions
    Items = function()
        return ox_inventory:Items() or {}
    end,
})
