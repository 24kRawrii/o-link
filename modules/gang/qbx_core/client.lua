if GetResourceState('qbx_core') == 'missing' then return end
if GetResourceState('oxide-core') == 'started' then return end

olink._register('gang', {
    ---@return table|nil { name, label, grade, gradeLabel, rank }
    Get = function()
        local data = exports.qbx_core:GetPlayerData()
        if not data or not data.gang then return nil end
        local gang = data.gang
        if gang.name == 'none' then return nil end
        return {
            name       = gang.name,
            label      = gang.label or gang.name,
            grade      = gang.grade and gang.grade.name or 'default',
            gradeLabel = gang.grade and gang.grade.name or 'Default',
            rank       = gang.grade and gang.grade.level or 0,
        }
    end,
})
