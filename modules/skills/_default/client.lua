-- Default skill system client fallback.
-- Uses a callback to query the server for skill level (framework-agnostic).

if GetResourceState('pickle_xp') == 'started' then return end
if GetResourceState('OT_skills') == 'started' then return end
if GetResourceState('evolent_skills') == 'started' then return end

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
