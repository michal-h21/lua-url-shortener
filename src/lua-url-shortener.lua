#!/usr/bin/env lua
--
-- lua-url-shortener-0.1.0
--
-- The MIT License (MIT)
--
-- Copyright (c) 2021, Michal Hoftich
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--

local PKG_AUTHOR = 'Michal Hoftich'
local PKG_EMAIL = 'michal.h21@gmail.com'
local PKG_VERSION = '0.1.0-1'


local lua_url_shortener = {
    _VERSION = '0.1.0-1',
}


local argparse = require "argparse"

local generator = require "lua-url-shortener.generator"
local config    = require "lua-url-shortener.config"
local add       = require "lua-url-shortener.add"

local parser = argparse() {
  name        = "lushorten",
  description = "Make short URLs"
}

------------------------
-- define subcommands --
------------------------
-- add new url
local add_cmd = parser:command "add" "a"

-- generate 
local generate_cmd = parser:command "generate" "g"



local args = parser:parse()

if args.add then
  print("Add")
elseif args.generate then
  print("Generate")
end

