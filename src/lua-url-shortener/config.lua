local M = {}

-- 
local function file_exists(filename)
  local f = io.open(filename, "r")
  if not f then return false end
  f:close()
  return true
end

-- set some default values
local default_env = {
  -- these values are used in add.lua
  alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
  format   = "%y.%m.$alphacount"
}

-- load Lua config file in a sandbox
local function load_config(filename)
  local env = {}
  -- initialize env with default values
  for k,v in pairs(default_env) do env[k] = v end
  local fun, err = loadfile(filename, "t", env)
  if fun then
    fun()
    return env
  end
  return nil, err
end

-- find the config file in XDG_CONFIG_HOME  or in the HOME directry
-- the XDG tree is looked up first, the $HOME is used only when it cannot be
-- find in the former
-- This function comes from make4ht
local function xdg_config (filename, xdg_config_name)
  local dotfilename = "." .. filename
  local xdg_config_name = xdg_config_name or "config.lua"
  local xdg = os.getenv("XDG_CONFIG_HOME") or ((os.getenv("HOME") or "") ..  "/.config")
  local home = os.getenv("HOME") or os.getenv("USERPROFILE")
  local make_name = function(tbl) return table.concat(tbl, "/") end
  if xdg then
    -- filename like ~/.config/lushorten/config.lua
    local fn = make_name{ xdg ,filename , xdg_config_name }
    if file_exists(fn) then
      return fn
    end
  end
  if home then
    -- ~/.make4ht
    local fn = make_name{ home, dotfilename }
    if file_exists(fn) then
      return fn
    end
  end
end


M.file_exists = file_exists
M.load_config = load_config
M.default_env = default_env
M.xdg_config  = xdg_config

return M
