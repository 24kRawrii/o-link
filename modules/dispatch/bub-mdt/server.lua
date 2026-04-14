if not olink._guardImpl('Dispatch', 'bub-mdt', 'bub-mdt') then return end

olink._register('dispatch', {
    ---@return string
    GetResourceName = function()
        return 'bub-mdt'
    end,
})
