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
  "lua >= 5.1"
}
build = {
  type = "builtin",
   modules = {
    lua-url-shortener = "src/lua-url-shortener.lua"
  }
}