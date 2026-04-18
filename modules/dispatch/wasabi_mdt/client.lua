if not olink._guardImpl('Dispatch', 'wasabi_mdt', 'wasabi_mdt') then return end

olink._register('dispatch', {
    ---@return string
    GetResourceName = function()
        return 'wasabi_mdt'
    end,

    ---@param data table
    SendAlert = function(data)
        local fallbackCoords = GetEntityCoords(PlayerPedId())
        local coords = data.coords or fallbackCoords
        local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)) or 'Unknown'
        exports.wasabi_mdt:CreateDispatch({
            type = data.code or '10-80',
            title = data.code or '10-80',
            description = data.message or 'No message provided',
            location = streetName,
            coords = { x = coords.x, y = coords.y, z = coords.z },
        })
    end,
})
