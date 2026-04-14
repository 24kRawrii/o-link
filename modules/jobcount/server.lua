-- Internal job count tracking system.
-- Maintains a table of { jobName -> count } and broadcasts via GlobalState.

local jobCounts  = {}
local playerJobs = {}

local function broadcast()
    GlobalState.jobcounts = jobCounts
end

local function addJobCount(src, jobName)
    if not jobName or jobName == 'unemployed' then return end
    local oldJob = playerJobs[src]
    if oldJob == jobName then return end
    if oldJob then
        jobCounts[oldJob] = math.max(0, (jobCounts[oldJob] or 0) - 1)
        if jobCounts[oldJob] == 0 then jobCounts[oldJob] = nil end
    end
    playerJobs[src] = jobName
    jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
    broadcast()
end

local function removeJobCount(src)
    local jobName = playerJobs[src]
    if not jobName then return end
    jobCounts[jobName] = math.max(0, (jobCounts[jobName] or 0) - 1)
    if jobCounts[jobName] == 0 then jobCounts[jobName] = nil end
    playerJobs[src] = nil
    broadcast()
end

AddEventHandler('olink:server:playerReady', function(src)
    if not olink.job then return end
    local jobData = olink.job.Get(src)
    if jobData and jobData.name then
        addJobCount(src, jobData.name)
    end
end)

AddEventHandler('olink:server:playerUnload', function(src)
    removeJobCount(src)
end)

AddEventHandler('olink:server:playerDropped', function(src)
    removeJobCount(src)
end)

AddEventHandler('olink:server:jobChanged', function(src, jobName)
    addJobCount(src, jobName)
end)

olink._register('jobcount', {
    ---@param jobName string
    ---@return number
    GetJobCount = function(jobName)
        return jobCounts[jobName] or 0
    end,

    ---@param tbl table list of job names
    ---@return number total
    GetJobCountTotal = function(tbl)
        local total = 0
        for _, name in ipairs(tbl) do
            total = total + (jobCounts[name] or 0)
        end
        return total
    end,

    ---@param src number
    ---@param jobName string
    AddJobCount = function(src, jobName)
        addJobCount(src, jobName)
    end,

    ---@param src number
    ---@param jobName string|nil
    RemoveJobCount = function(src, jobName)
        removeJobCount(src)
    end,

    ---@param src number
    ---@return string|nil
    SearchJobCountBySource = function(src)
        return playerJobs[src]
    end,
})
