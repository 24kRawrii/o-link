if not olink._guardImpl('Dispatch', 'wasabi_mdt', 'wasabi_mdt') then return end

olink._register('dispatch', {
    ---@return string
    GetResourceName = function()
        return 'wasabi_mdt'
    end,
})
