if not olink._guardImpl('Housing', 'esx_property', 'esx_property') then return end

olink._register('housing', {
    ---@return string
    GetResourceName = function()
        return 'esx_property'
    end,
})
