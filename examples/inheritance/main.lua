package.path = package.path .. ";../../?.lua"
_G.BaseObj = require "baseObj"

local HondaRebel = require "hondaRebel"
local ToyotaAvalon = require "toyotaAvalon"
local FiatMultipla = require "fiatMultipla"

print(BaseObj:applyTo(getmetatable(FiatMultipla).__extends))
print(BaseObj:applyTo(getmetatable(ToyotaAvalon).__extends))
print(BaseObj:applyTo(getmetatable(HondaRebel).__extends))
print(FiatMultipla)
print(ToyotaAvalon)
print(HondaRebel)
