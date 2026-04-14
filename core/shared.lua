olink = {}

local capabilities = {}

local overrideKeyMap = {
    framework = 'Framework',
    character = 'Character',
    job = 'Job',
    money = 'Money',
    inventory = 'Inventory',
    vehicles = 'Vehicles',
    vehicleproperties = 'VehicleProperties',
    vehicleownership = 'VehicleOwnership',
    notify = 'Notify',
    banking = 'Banking',
    helptext = 'HelpText',
    target = 'Target',
    progressbar = 'ProgressBar',
    vehiclekey = 'VehicleKey',
    fuel = 'Fuel',
    weather = 'Weather',
    input = 'Input',
    menu = 'Menu',
    zones = 'Zones',
    phone = 'Phone',
    clothing = 'Clothing',
    dispatch = 'Dispatch',
    doorlock = 'Doorlock',
    housing = 'Housing',
    bossmenu = 'BossMenu',
    skills = 'Skills',
    death = 'Death',
    needs = 'Needs',
    gang = 'Gang',
}

local function normalizeName(value)
    return type(value) == 'string' and value:lower() or nil
end

---@param namespace string Module namespace (e.g. 'framework', 'character', 'job')
---@param impl table Table of functions returned by the module implementation
function olink._register(namespace, impl)
    olink[namespace] = impl
    capabilities[namespace] = true
end

---@param namespace string
---@return string
function olink._getOverrideKey(namespace)
    return overrideKeyMap[normalizeName(namespace)] or namespace
end

---@param namespace string
---@return string|nil
function olink._getOverride(namespace)
    local overrides = Config and Config.Overrides
    if type(overrides) ~= 'table' then return nil end

    local key = olink._getOverrideKey(namespace)
    local value = overrides[key]
    if type(value) ~= 'string' or value == '' then return nil end

    return value
end

---@param namespace string
---@param implName string
---@return boolean|nil
function olink._overrideMatches(namespace, implName)
    local override = olink._getOverride(namespace)
    if not override then return nil end

    return normalizeName(override) == normalizeName(implName)
end

---@param namespace string
---@return boolean
function olink._hasOverride(namespace)
    return olink._getOverride(namespace) ~= nil
end

---@param namespace string
---@param implName string
---@param resourceName string|false|nil
---@return boolean
function olink._guardImpl(namespace, implName, resourceName)
    local matches = olink._overrideMatches(namespace, implName)
    if matches == false then return false end

    if resourceName == false then return true end

    return GetResourceState(resourceName or implName) ~= 'missing'
end

---Check whether a module or specific function is available.
---@param path string Dot-separated path (e.g. 'character', 'character.SetBoss')
---@return boolean
function olink.supports(path)
    local node = olink
    for part in path:gmatch('[^.]+') do
        if type(node) ~= 'table' then return false end
        node = node[part]
        if node == nil then return false end
    end
    return true
end

---@return table<string, boolean> Map of loaded module namespaces
function olink._getCapabilities()
    return capabilities
end

---Strip .png / .webp extension from an item name for image path resolution.
---@param item string
---@return string
function olink._stripExt(item)
    return item:gsub('%.png$', ''):gsub('%.webp$', '')
end

exports('olink', function()
    return olink
end)
