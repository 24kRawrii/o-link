if not olink._guardImpl('Housing', 'qb-appartments', 'qb-appartments') then return end

olink._register('housing', {
    ---@return string
    GetResourceName = function()
        return 'qb-appartments'
    end,
})
