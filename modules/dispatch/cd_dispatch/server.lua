if not olink._guardImpl('Dispatch', 'cd_dispatch', 'cd_dispatch') then return end

olink._register('dispatch', {
    ---@return string
    GetResourceName = function()
        return 'cd_dispatch'
    end,
})
