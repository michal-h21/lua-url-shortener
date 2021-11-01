local config = require "lua-url-shortener.config"


describe("Test config file", function()
  local test_config_filename = "spec/config-sample.lua"
  it("should find config file", function()
    assert.truthy(config.file_exists(test_config_filename))
  end)
  local test, msg = config.load_config(test_config_filename)
  it("should return table with config values", function()
    assert.same(test.a, 10)
    assert.same(test.b, 20)
  end)
end)

