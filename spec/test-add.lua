local add = require "lua-url-shortener.add"


-- testing data
local data = {
  {url = "xxx", date = 1635800425, short = ""},
  {url = "xxx", date = 1635800425, short = ""},
  {url = "xxx", date = 1635800425 + 24 * 3600, short = ""}
}
-- 2021/11/01
local time = 1635771170
params = {
  time = time,
  data = data
}


describe("Test interpolation", function()
  -- testing data
  
  local interpolators = add.interpolators
  it("should count urls from a month", function()
    -- there are three records in January, 
    -- but count calculates number of the next record, thus 4
    assert.same(interpolators.count(params),4)
  end)
  it("should count urls alphanumerically", function()
    assert.same(interpolators.alphacount(params),"d")
  end)
  it("should count urls from a  day", function()
    params.format = "%Y-%m-%d-$count"
    -- two records from the same day + 1
    assert.same(interpolators.count(params), 3)
  end)
  it("should support alpha dates", function()
    -- it should be the same as %Y-%m-%d
    params.format ="$alphayear.$alphamonth.$alphaday"
    assert.same(interpolators.count(params), 3)
    assert.same(interpolators.alphayear(params),  "FK") -- 2021
    assert.same(interpolators.alphamonth(params), "k")  -- 11
    assert.same(interpolators.alphaday(params),   "a")  -- 1
  end)
end)

describe("Test number to string", function()
  it("should convert numbers to string", function()
    assert.same(add.number_to_letter(1),  "a")
    assert.same(add.number_to_letter(64), "ab")
    assert.same(add.number_to_letter(27), "A")
  end)
end)

describe("Test making of short URL", function()
  local make = add.make
  local newparams = {}
  for k,v in pairs(params) do newparams[k] = v end
  it("Should support basic format", function()
    newparams.format ="$alphayear.$alphamonth.$alphaday.$alphacount"
    print(make(newparams))
    newparams.format ="$alphayear$alphamonth$alphacount"
    print(make(newparams))
    newparams.alphabet = "abcdefghij"
    print(make(newparams))
   
  end)
end)
