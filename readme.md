# Why ?


because it's much easier to parse bytecode than to parse code itself




Symbols dumps : 


```Lua
function normal_func()
	print()
	print()
end

-- function commented function() end
function --[[b]]perfect_parsing --[[allalalal]] ()

end

-- infinite loop that prove code isn't ran but bytecode only parsed
while true do
end

str = "function stringFunction() end"

function globalTable.subTable.subTable2.subFunction(yolo)
end

_G["LOL"] = function() end
_G["LOL"] = function() end -- double definition
local lol = "LOL"
_G[lol] = function() end -- not working but should :(
--[[
doesn't show but should, bur concat operator
could be overwrote so it's not that bad
]]
_G["LOL" .. "CONCATENED"] = function() end
_G[3] = function() end -- should not show because name is bad
lambdaFunctionName = function() end

function MainFunc()
	function SubFunc()
	end

	function table.SubFunc()
	end
end

local function dab_NamE_THaTshoulD_noTshOW()
end

function dab_NamE_THaTshoulD_shOW()
end
```

Returns : 


```
normal_func     1:4
perfect_parsing 7:9
globalTable.subTable.subTable2.subFunction      17:18
_G.LOL  20:20
_G.LOL  21:21
lambdaFunctionName      30:30
MainFunc        32:38
SubFunc 33:34
table.SubFunc   36:37
dab_NamE_THaTshoulD_shOW        43:44
```
