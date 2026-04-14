-- Default skill system fallback.
-- Only loads when no external skill resource is running.
-- Provides a RuneScape-style XP curve with character metadata persistence.

if GetResourceState('pickle_xp') == 'started' then return end
if GetResourceState('OT_skills') == 'started' then return end
if GetResourceState('evolent_skills') == 'started' then return end

local Skills = {}
local cachedXp = {}

---RuneScape XP curve
---@param level number
---@return number
local function GetXPForLevel(level)
    if level <= 1 then return 0 end
    if cachedXp[level] then return cachedXp[level] end
    local xp = 0
    for n = 1, level - 1 do
        xp = xp + math.floor(n + 300 * (2 ^ (n / 7)))
    end
    local result = math.floor(xp / 4)
    cachedXp[level] = result
    return result
end

local function GetPlayerSkills(src)
    if not olink.character then return {} end
    return olink.character.GetMetadata(src, 'olink_skills') or {}
end

local function SavePlayerSkills(src, data)
    if not olink.character then return end
    olink.character.SetMetadata(src, 'olink_skills', data)
end

olink._register('skills', {
    All = Skills,

    GetResourceName = function() return '_default' end,

    ---@param name string
    ---@param maxLevel number|nil
    ---@param baseXP number|nil
    ---@return table
    Create = function(name, maxLevel, baseXP)
        Skills[name] = { name = name, maxLevel = maxLevel or 99, baseXP = baseXP or 50 }
        return Skills[name]
    end,

    ---@param level number
    ---@return number
    GetXPForLevel = GetXPForLevel,

    ---@param baseXP number
    ---@param playerLevel number
    ---@return number
    GetScaledXP = function(baseXP, playerLevel)
        return math.floor(baseXP * (1 + playerLevel * 0.05))
    end,

    ---@param level number
    ---@return number
    GetXPRequiredForLevel = function(level)
        if level <= 1 then return GetXPForLevel(2) end
        return GetXPForLevel(level + 1) - GetXPForLevel(level)
    end,

    ---@param src number
    ---@param skillName string
    ---@return number
    GetSkillLevel = function(src, skillName)
        local data = GetPlayerSkills(src)
        return data[skillName] and data[skillName].level or 1
    end,

    ---@param src number
    ---@param skillName string
    ---@return number
    GetXP = function(src, skillName)
        local data = GetPlayerSkills(src)
        return data[skillName] and data[skillName].currentXP or 0
    end,

    ---@param src number
    ---@param skillName string
    ---@param amount number
    ---@return boolean, number, number level, currentXP
    AddXp = function(src, skillName, amount)
        if not Skills[skillName] then
            Skills[skillName] = { name = skillName, maxLevel = 99, baseXP = 50 }
        end
        local data = GetPlayerSkills(src)
        local skill = data[skillName] or { level = 1, currentXP = 0 }
        local maxLevel = Skills[skillName].maxLevel or 99

        skill.currentXP = (skill.currentXP or 0) + (amount or 0)
        local currentLevel = skill.level or 1
        local nextXP = GetXPForLevel(currentLevel + 1) - GetXPForLevel(currentLevel)
        while skill.currentXP >= nextXP and currentLevel < maxLevel do
            skill.currentXP = skill.currentXP - nextXP
            currentLevel = currentLevel + 1
            nextXP = GetXPForLevel(currentLevel + 1) - GetXPForLevel(currentLevel)
        end
        skill.level = currentLevel

        data[skillName] = skill
        SavePlayerSkills(src, data)
        return true, skill.level, skill.currentXP
    end,

    ---@param src number
    ---@param skillName string
    ---@param amount number
    ---@return boolean
    RemoveXp = function(src, skillName, amount)
        local data = GetPlayerSkills(src)
        local skill = data[skillName] or { level = 1, currentXP = 0 }
        skill.currentXP = math.max(0, (skill.currentXP or 0) - (amount or 0))
        data[skillName] = skill
        SavePlayerSkills(src, data)
        return true
    end,

    ---@param src number
    ---@param skillName string
    ---@param level number
    ---@return boolean
    SetSkillLevel = function(src, skillName, level)
        local data = GetPlayerSkills(src)
        local maxLevel = Skills[skillName] and Skills[skillName].maxLevel or 99
        data[skillName] = { level = math.max(1, math.min(maxLevel, level)), currentXP = 0 }
        SavePlayerSkills(src, data)
        return true
    end,

    ---@param src number
    ---@param skillName string
    ---@param xp number
    ---@return boolean
    SetXP = function(src, skillName, xp)
        local data = GetPlayerSkills(src)
        local skill = data[skillName] or { level = 1, currentXP = 0 }
        skill.currentXP = math.max(0, xp)
        data[skillName] = skill
        SavePlayerSkills(src, data)
        return true
    end,
})

-- Callback for client-side skill level queries
if olink.callback then
    olink.callback.Register('o-link:skills:getLevel', function(src, skillName)
        local data = GetPlayerSkills(src)
        return data[skillName] and data[skillName].level or 1
    end)
end
