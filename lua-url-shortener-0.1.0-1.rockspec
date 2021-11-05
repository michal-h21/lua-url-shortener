package = "lua-url-shortener"
version = "0.1.0-1"
source = {
  url = "https://github.com/michal-h21/lua-url-shortener/archive/v0.1.0.tar.gz",
  dir = "lua-url-shortener-0.1.0-1"
}
description = {
  summary = "lua-url-shortener",
  detailed = [[
    URL shortener for Github Actions
  ]],
  homepage = "https://github.com/michal-h21/lua-url-shortener/",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1",
  "argparse",
}
build = {
  type = "builtin",
   modules = {
    ["lua-url-shortener.generator"] = "src/lua-url-shortener/generator.lua",
    ["lua-url-shortener.config"]    = "src/lua-url-shortener/config.lua",
    ["lua-url-shortener.add"]       = "src/lua-url-shortener/add.lua",
    ["lua-url-shortener.log"]       = "src/lua-url-shortener/log.lua",
  },
  install = {
    bin = {
      lushorten = "src/lua-url-shortener.lua"
    }
  }

}
