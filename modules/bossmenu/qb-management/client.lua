if not olink._guardImpl('BossMenu', 'qb-management', 'qb-management') then return end
if not olink._hasOverride('BossMenu') and GetResourceState('qbx_management') == 'started' then return end

olink._register('bossmenu', {
    ---@return string
    GetResourceName = function()
        return 'qb-management'
    end,
})
