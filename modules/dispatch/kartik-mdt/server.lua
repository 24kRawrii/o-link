if not olink._guardImpl('Dispatch', 'kartik-mdt', 'kartik-mdt') then return end

olink._register('dispatch', {
    ---@return string
    GetResourceName = function()
        return 'kartik-mdt'
    end,
})
