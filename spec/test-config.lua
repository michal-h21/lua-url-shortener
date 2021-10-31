local config = require "lua-url-shortener.config"

local test_config_filename = "spec/config-sample.lua"
local test, msg = config.load_config(test_config_filename)

print(config.file_exists(test_config_filename))

