.Phony: test

test:
	busted spec/test-config.lua

install:
	luarocks make --local
