if not olink._guardImpl('Housing', 'ps-housing', 'ps-housing') then return end

olink._register('housing', {
    ---@return string
    GetResourceName = function()
        return 'ps-housing'
    end,
})
