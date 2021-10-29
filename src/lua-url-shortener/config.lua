local function if_file_exists(filename)
  local f = io.open(filename, "r")
  if not f then return false end
  f:close()
  return true
end

-- config file should be in Lua
local function load_config(filename)
  local env = {}
  local fun, err loadfile(filename, "t", env)
  if fun then
    fun()
    return env
  end
  return nil, err
end
