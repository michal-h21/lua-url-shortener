local add = require "lua-url-shortener.add"


describe("Test interpolation", function()
  -- testing data
  local data = {
    {url = "xxx", date = "2021-11-01", short = ""},
    {url = "xxx", date = "2021-11-01", short = ""},
    {url = "xxx", date = "2021-11-02", short = ""}
  }
  -- 2021/11/01
  local time = 1635771170
  params = {
    time = time,
    data = data
  }
  local interpolators = add.interpolators
  print(interpolators.count(params))
end)
