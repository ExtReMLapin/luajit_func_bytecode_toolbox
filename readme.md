# Why ?


Because it's much easier (and faster) to parse bytecode than to parse code itself

Because there are some detections that CANNOT (or it's really dirty) be done using only hooks and detours


You can detect which function pass you an argument, the type of the argument but you can't detect if that argument was cached or not.

Example from garry's mod : 

the function `Color(255,255,255)` generates a color object.

This object is used in render contexts.

If you have "dynamic" variables inside this function fine, i guess it's perfectly fine to call it to regenrate a color on the fly like this : 

`Color(distance, distance, distance)` however, `Color(42,256,42)` is wrong and it should be cached.

So yeah you could read the callstack and manually read the file ... but that's dirty.

And this is why i created this library, you can know if the function call uses KSHORTS (constants) or upvalues.

With is you can do much more things like symbols dumps :

You could open a file and make your own parser but it's going to be a mess, take you some time and there is always one specific syntax what you will not handle/handle differently from LuaJIT.

This is why i decided to stick with the LuaJIT parser and just parse the bytecode to find what I need.


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
