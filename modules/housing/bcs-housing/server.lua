if not olink._guardImpl('Housing', 'bcs-housing', 'bcs-housing') then return end

olink._register('housing', {
    ---@return string
    GetResourceName = function()
        return 'bcs-housing'
    end,
})
