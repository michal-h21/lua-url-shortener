.Phony: test

test:
	busted spec/test-config.lua
	busted spec/test-add.lua

install:
	luarocks make --local
