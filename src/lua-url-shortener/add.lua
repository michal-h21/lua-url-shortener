local M = {}

-- default format string for short URL
-- %y and %m are formatting instructions for os.date
-- $count is placeholder for the interpolation function
local default_format = "%y.%m.$count"

-- characters used in conversion from number to string
local default_alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

local function number_to_letter(number, alphabet)
  local alphabet = alphabet or default_alphabet
  -- we support only ASCII alphabets, I don't think that we need to support UTF-8 in URLs
  local alpha_len = string.len(alphabet)
  local quot = math.floor(number / alpha_len)
  local rem  = number % alpha_len
  local letter = string.sub(alphabet, rem, rem)
  -- we also support only positive numbers, as we need to support only counters
  if quot == 0 then
    return letter
  else
    return number_to_letter(quot, alphabet) .. letter
  end
end


-- format string can contain placeholder that will be interpolated
-- using functions in this table
-- $count -> interpolators[count](params)
local interpolators = {}

interpolators.count = function(params)
  -- count records from the given time (day by default)
  local format = params.format or default_format
  -- convert alpha represenations of dates to os.date format, all records would be counted otherwise
  format  = format:gsub("%$(%w+)", {alphayear = "%Y", alphamonth = "%m", alphaday = "%d"})
  local today = os.date(format, params.time)
  local count = 0
  for k,v in ipairs(params.data) do
    if os.date(format, v.date) == today then count = count + 1 end
  end
  -- increase found records, because we add a new record for today
  return count + 1
end

interpolators.alphacount = function(params)
  -- convert count to alpha characters
  return number_to_letter(interpolators.count(params), params.alphabet)
end

-- 
local function alphafunction(format)
  return function(params)
    local date = tonumber(os.date(format, params.time))
    local alphabet = params.alphabet or default_alphabet
    return number_to_letter(date, alphabet)
  end
end

-- some interpolators to change date to alpha number
interpolators.alphayear  = alphafunction("%Y")
interpolators.alphamonth = alphafunction("%m")
interpolators.alphaday   = alphafunction("%d")



-- make new short URL
local function make(params)
  local params = params or {}
  params.time = params.time or os.time()
  params.format = params.format or default_format
  params.alphabet = params.alphabet or default_alphabet
  -- fill date placeholders
  local filled = os.date(params.format, params.time)
  -- interpolate placeholders
  filled = filled:gsub("%$(%w+)", function(name)
    local fn = interpolators[name]
    if fn then
      return fn(params)
    else
      log.error("Unknown placeholder: " .. name)
    end
  end)
  return filled
end

-- exports
M.interpolators = interpolators
M.number_to_letter = number_to_letter
M.make = make 

return M
