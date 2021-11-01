local M = {}

-- format string can contain placeholder that will be interpolated
-- using functions in this table
-- $count -> interpolators[count](params)
local interpolators = {
  count = function(params)
    -- count urls added today
    local format = params.date_format or "%Y-%m-%d"
    local today = os.date(format, params.time)
    local count = 0
    for k,v in ipairs(params.data) do

      if v.date == today then count = count + 1 end
    end
    -- increase found records, because we add a new record for today
    return count + 1
  end

}

local default_format = "%y.%m.$count"

-- make new name short URL
local function make(format, params)


end

-- exports
M.interpolators = interpolators
M.make = make 

return M
