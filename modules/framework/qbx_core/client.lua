if not olink._guardImpl('Framework', 'qbx_core', 'qbx_core') then return end

local QBox = exports.qbx_core

olink._register('framework', {
    ---@return string
    GetName = function()
        return 'qbx_core'
    end,

    ---@return boolean
    GetIsPlayerLoaded = function()
        return LocalPlayer.state.isLoggedIn or false
    end,
})
