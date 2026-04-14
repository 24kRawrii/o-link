-- Default skill system client fallback.
-- Uses a callback to query the server for skill level (framework-agnostic).

if not olink._guardImpl('Skills', '_default', false) then return end
if not olink._hasOverride('Skills') and GetResourceState('pickle_xp') == 'started' then return end
if not olink._hasOverride('Skills') and GetResourceState('OT_skills') == 'started' then return end
if not olink._hasOverride('Skills') and GetResourceState('evolent_skills') == 'started' then return end

olink._register('skills', {
    GetResourceName = function() return '_default' end,

    ---@param skillName string
    ---@return number
    GetSkillLevel = function(skillName)
        if olink.callback then
            return olink.callback.Trigger('o-link:skills:getLevel', false, skillName) or 1
        end
        return 1
    end,
})
