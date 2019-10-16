assert(jit, "You're supposed to run this tool using LuaJIT, not Lua")
assert(jit.os == "Windows", "Only windows is supported ... for now")

local tmp_documentation = {{op="ISLT",d="var",a="var",description="Jump if A < D",},{op="ISGE",d="var",a="var",description="Jump if A ≥ D",},{op="ISLE",d="var",a="var",description="Jump if A ≤ D",},{op="ISGT",d="var",a="var",description="Jump if A > D",},{op="ISEQV",d="var",a="var",description="Jump if A = D",},{op="ISNEV",d="var",a="var",description="Jump if A ≠ D",},{op="ISEQS",d="str",a="var",description="Jump if A = D",},{op="ISNES",d="str",a="var",description="Jump if A ≠ D",},{op="ISEQN",d="num",a="var",description="Jump if A = D",},{op="ISNEN",d="num",a="var",description="Jump if A ≠ D",},{op="ISEQP",d="pri",a="var",description="Jump if A = D",},{op="ISNEP",d="pri",a="var",description="Jump if A ≠ D",},{op="ISTC",d="var",a="dst",description="Copy D to A and jump",},{op="ISFC",d="var",a="dst",description="Copy D to A and jump",},{op="IST",d="var",a=" ",description="Jump if D is true",},{op="ISF",d="var",a=" ",description="Jump if D is false",},{op="MOV",d="var",a="dst",description="Copy D to A",},{op="NOT",d="var",a="dst",description="Set A to boolean not of D",},{op="UNM",d="var",a="dst",description="Set A to -D (unary minus)",},{op="LEN",d="var",a="dst",description="Set A to #D (object length)",},{op="ADDVN",a="dst",b="var",c="num",description="A = B + C",},{op="SUBVN",a="dst",b="var",c="num",description="A = B - C",},{op="MULVN",a="dst",b="var",c="num",description="A = B * C",},{op="DIVVN",a="dst",b="var",c="num",description="A = B / C",},{op="MODVN",a="dst",b="var",c="num",description="A = B % C",},{op="ADDNV",a="dst",b="var",c="num",description="A = C + B",},{op="SUBNV",a="dst",b="var",c="num",description="A = C - B",},{op="MULNV",a="dst",b="var",c="num",description="A = C * B",},{op="DIVNV",a="dst",b="var",c="num",description="A = C / B",},{op="MODNV",a="dst",b="var",c="num",description="A = C % B",},{op="ADDVV",a="dst",b="var",c="var",description="A = B + C",},{op="SUBVV",a="dst",b="var",c="var",description="A = B - C",},{op="MULVV",a="dst",b="var",c="var",description="A = B * C",},{op="DIVVV",a="dst",b="var",c="var",description="A = B / C",},{op="MODVV",a="dst",b="var",c="var",description="A = B % C",},{op="POW",a="dst",b="var",c="var",description="A = B ^ C",},{op="CAT",a="dst",b="rbase",c="rbase",description="A = B .. ~ .. C",},{op="KSTR",d="str",a="dst",description="Set A to string constant D",},{op="KCDATA",d="cdata",a="dst",description="Set A to cdata constant D",},{op="KSHORT",d="lits",a="dst",description="Set A to 16 bit signed integer D",},{op="KNUM",d="num",a="dst",description="Set A to number constant D",},{op="KPRI",d="pri",a="dst",description="Set A to primitive D",},{op="KNIL",d="base",a="base",description="Set slots A to D to nil",},{op="UGET",d="uv",a="dst",description="Set A to upvalue D",},{op="USETV",d="var",a="uv",description="Set upvalue A to D",},{op="USETS",d="str",a="uv",description="Set upvalue A to string constant D",},{op="USETN",d="num",a="uv",description="Set upvalue A to number constant D",},{op="USETP",d="pri",a="uv",description="Set upvalue A to primitive D",},{op="UCLO",d="jump",a="rbase",description="Close upvalues for slots ≥ rbase and jump to target D",},{op="FNEW",d="func",a="dst",description="Create new closure from prototype D and store it in A",},{op="TNEW",b="",["c/d"]="lit",a="dst",description="Set A to new table with size D (see below)",},{op="TDUP",b="",["c/d"]="tab",a="dst",description="Set A to duplicated template table D",},{op="GGET",b="",["c/d"]="str",a="dst",description="A = _G[D]",},{op="GSET",b="",["c/d"]="str",a="var",description="_G[D] = A",},{op="TGETV",b="var",["c/d"]="var",a="dst",description="A = B[C]",},{op="TGETS",b="var",["c/d"]="str",a="dst",description="A = B[C]",},{op="TGETB",b="var",["c/d"]="lit",a="dst",description="A = B[C]",},{op="TSETV",b="var",["c/d"]="var",a="var",description="B[C] = A",},{op="TSETS",b="var",["c/d"]="str",a="var",description="B[C] = A",},{op="TSETB",b="var",["c/d"]="lit",a="var",description="B[C] = A",},{op="TSETM",b="",["c/d"]="num*",a="base",description="(A-1)[D]",},{op="CALLM",b="lit",["c/d"]="lit",a="base",description="Call: A",},{op="CALL",b="lit",["c/d"]="lit",a="base",description="Call: A",},{op="CALLMT",b="",["c/d"]="lit",a="base",description="Tailcall: return A(A+1",},{op="CALLT",b="",["c/d"]="lit",a="base",description="Tailcall: return A(A+1",},{op="ITERC",b="lit",["c/d"]="lit",a="base",description="Call iterator: A",},{op="ITERN",b="lit",["c/d"]="lit",a="base",description="Specialized ITERC",},{op="VARG",b="lit",["c/d"]="lit",a="base",description="Vararg: A",},{op="ISNEXT",b="",["c/d"]="jump",a="base",description="Verify ITERN specialization and jump",},{op="RETM",d="lit",a="base",description="return A",},{op="RET",d="lit",a="rbase",description="return A",},{op="RET0",d="lit",a="rbase",description="return",},{op="RET1",d="lit",a="rbase",description="return A",},{op="FORI",d="jump",a="base",description="Numeric 'for' loop init",},{op="JFORI",d="jump",a="base",description="Numeric 'for' loop init",},{op="FORL",d="jump",a="base",description="Numeric 'for' loop",},{op="IFORL",d="jump",a="base",description="Numeric 'for' loop",},{op="JFORL",d="lit",a="base",description="Numeric 'for' loop",},{op="ITERL",d="jump",a="base",description="Iterator 'for' loop",},{op="IITERL",d="jump",a="base",description="Iterator 'for' loop",},{op="JITERL",d="lit",a="base",description="Iterator 'for' loop",},{op="LOOP",d="jump",a="rbase",description="Generic loop",},{op="ILOOP",d="jump",a="rbase",description="Generic loop",},{op="JLOOP",d="lit",a="rbase",description="Generic loop",},{op="JMP",d="jump",a="rbase",description="Jump",},{op="FUNCF",d="",a="rbase",description="Fixed-arg Lua function",},{op="IFUNCF",d="",a="rbase",description="Fixed-arg Lua function",},{op="JFUNCF",d="lit",a="rbase",description="Fixed-arg Lua function",},{op="FUNCV",d="",a="rbase",description="Vararg Lua function",},{op="IFUNCV",d="",a="rbase",description="Vararg Lua function",},{op="JFUNCV",d="lit",a="rbase",description="Vararg Lua function",},{op="FUNCC",d="",a="rbase",description="Pseudo-header for C functions",},{op="FUNCCW",d="",a="rbase",description="Pseudo-header for wrapped C functions",},}

local DEBUG = false


local documentation = {}


for k, v in ipairs(tmp_documentation) do
	documentation[v.op] = v
end


jit.util = jit.util or require("jit.util")

local OPNAMES = {}

-- for gmod, check your luajit version and import it manually
local vmdef = require("jit.vmdef")
local bcnames = vmdef.bcnames
local INST = {}

do
	local i = 0

	for str in bcnames:gmatch"......" do
		str = str:gsub("%s", "")
		OPNAMES[i] = str
		INST[str] = i
		i = i + 1
	end
end

assert(INST.ISLT == 0)

if DEBUG then
	for k, v in pairs(documentation) do
		assert(INST[k], "Documentation for unknown instructions : " .. k)
	end

	for k, v in pairs(OPNAMES) do
		if not documentation[v] then
			print("Instruction : " .. v .. " isn't documented")
		end
	end
end

local JIT_INST = {
	[INST.JFORI] = true,
	[INST.JFORL] = true,
	[INST.JITERL] = true,
	[INST.JLOOP] = true,
	[INST.JFUNCF] = true,
	[INST.JFUNCV] = true
}

local functions_headers = {
	[INST.FUNCF] = true,
	[INST.IFUNCF] = true,
	[INST.JFUNCF] = true,
	[INST.FUNCV] = true,
	[INST.IFUNCV] = true,
	[INST.JFUNCV] = true,
	[INST.FUNCC] = true,
	[INST.FUNCCW] = true,
	--[INST["FUNC*"]] = true
}


local ref_table_set_vars = {
	GGET = function(instruction, consts, upvalues)
		instruction.A_value = consts[instruction.D]
	end,
	UGET = function(instruction, consts, upvalues)
		instruction.A_value = upvalues[instruction.D]
	end,
	TGETS = function(instruction, consts, upvalues)
		instruction.A_value = "curTable[\""..  consts[instruction.C] .. "\"]"
	end,
	FNEW = function(instruction, consts, upvalues)
		instruction.A_value = tostring(consts[instruction.D])
	end,
	TSETS = function(instruction, consts, upvalues)
		instruction["curTable[\""..  consts[instruction.C] .. "\"]"] = "A"
	end,
	GSET = function(instruction, consts, upvalues)
		instruction["_G[\""..  consts[instruction.C] .. "\"]"] = "A"
	end,
}

local function getregisters(instruction, consts, upvalues)
	if ref_table_set_vars[instruction.OP_ENGLISH] then
		ref_table_set_vars[instruction.OP_ENGLISH](instruction, consts, upvalues)
	end
end

--fn is the function
--fast to true if you don't want any documentation and register filtering gives about 20-50% perf boost

local function disassemble_function(fn, fast)
	assert(fn, "function expected")
	assert(jit.util.funcinfo(fn).loc, "expected a Lua function, not a C one")
	local upvalues = {}
	local n = 0
	local upvalue = jit.util.funcuvname(fn, n)

	while (upvalue ~= nil) do
		upvalues[n] = upvalue
		n = n + 1
		upvalue = jit.util.funcuvname(fn, n)
	end

	local consts = {}
	n = -1
	local value = jit.util.funck(fn, n)

	while (value ~= nil) do
		consts[-1 * n - 1] = value
		n = n - 1
		value = jit.util.funck(fn, n)
	end

	n = 0
	local countBC = jit.util.funcinfo(fn).bytecodes
	local instructions = {}


	local header = bit.band(select(1, jit.util.funcbc(fn, 0)), 0xFF)
	assert(functions_headers[header], "Function header is unknown, found : " ..  OPNAMES[header] .. " with value : " .. header)

	--[[
		00010000 01001000 00100100 01001001
		|||||||| |||||||| |||||||| ||||||||
		B DATA   C DATA   A DATA   OP DATA
		|||||||||||||||||
		   D   D A T A
	]]
	while (n < countBC) do
		local ins = jit.util.funcbc(fn, n)
		local instruction = {}
		instruction.OP_CODE = bit.band(ins, 0xFF)
		if not fast then
			instruction.OP_ENGLISH = OPNAMES[instruction.OP_CODE]
			local _documentation = documentation[instruction.OP_ENGLISH]
			instruction.OP_DESCRIPTION = _documentation.description

			if (_documentation.c and _documentation.c:len() > 0) or (_documentation["c/d"] and _documentation["c/d"]:len() > 0) then
				instruction.C = bit.rshift(bit.band(ins, 0x00ff0000), 16)
			end

			if _documentation.b and _documentation.b:len() > 0 then
				instruction.B = bit.rshift(ins, 24)
			end

			if _documentation.a and _documentation.a:len() > 0 then
				instruction.A = bit.rshift(bit.band(ins, 0x0000ff00), 8)
			end

			if (_documentation.d and _documentation.d:len() > 0) or (_documentation["c/d"] and _documentation["c/d"]:len() > 0) then
				instruction.D = bit.rshift(ins, 16)
			end
			getregisters(instruction, consts, upvalues) 
		else
			instruction.C = bit.rshift(bit.band(ins, 0x00ff0000), 16)
			instruction.B = bit.rshift(ins, 24)
			instruction.A = bit.rshift(bit.band(ins, 0x0000ff00), 8)
			instruction.D = bit.rshift(ins, 16)
		end

		instructions[n] = instruction
		n = n + 1
	end

	local ret = {
		consts = consts,
		instructions = instructions,
		upvalues = upvalues
	}

	return ret
end


local function hasJITInstruction(fn)
	local countBC = jit.util.funcinfo(fn).bytecodes
	local n = 1
	while (n < countBC) do
		local ins = bit.band( jit.util.funcbc(fn, n), 0xFF)
		if JIT_INST[ins] then
			return true
		end
		n = n + 1
	end

	return false
end


local function JITLevel(fn)
	local instructions = 0
	local countBC = jit.util.funcinfo(fn).bytecodes
	local n = 1
	while (n < countBC) do
		local ins = bit.band( jit.util.funcbc(fn, n), 0xFF)
		if JIT_INST[ins] then
			instructions = instructions + 1
		end
		n = n + 1
	end

	return instructions


end

local function get_function_declarations(fn, recursive)
	assert(fn, "function expected")
	local symbols = {}
	local data = disassemble_function(fn, not DEBUG)
	local pos = 1
	local count = #data.instructions
	while (pos <= count) do
		local curIns = data.instructions[pos]
		-- new closure (function ?)


		-- function(...) <unreachable bytecode (from here)> end <-- we're here
		if curIns.OP_CODE == INST.FNEW then
			--consts also contains protos which are functions
			local _proto = jit.util.funcinfo(data.consts[curIns.D])
			local location = {_start = _proto.linedefined,
							_end = _proto.lastlinedefined}

			local fName;
			-- if we're not at the end of the function
			if pos + 1 ~= count then
				local nextIns = data.instructions[pos + 1]

				-- We got a Global Set instruction which mean there nothing of value before the FNEW instruction
				--
				--                 vvvvvvvvvvvvv <-- previous instruction
				--  _G[variable] = function(...) <unreachable bytecode (from here)> end
				--     ^^^^^^^^ <-- we're here
				if nextIns.OP_CODE == INST.GSET then
					fName = data.consts[nextIns.D]

				-- found instruction creating a function in a table TSETS = Table
				--[[ 	We got a Table Set instruction which mean we're already in a table
						and we need to find which one(s) by browsing the instructions before the FNEW instruction
						We should meet one or zero TGETS because we're doing potentiable table lookups
						
						Ex : 
						    Global Lookup [GGET]
						            ^
						            |
						            |   Table lookup [TGET] 
						            |    ^
						            |    |			FNEW
						            |    |           | 
						function potato.tata.yolo() .... end
						                        |
						                        v
						                       And now we're doing a table set since we're creating
						                       a new variable (a function) in an existing table [TSETS]

						--]]
				elseif nextIns.OP_CODE == INST.TSETS then
					fName = data.consts[nextIns.C]
					-- starting to loop back to fetch the parrent table(s)
					assert((pos - 1) > 0, "Error in instructions, expected TGETS or GGET but found nothing")
					local modifier = -1
					local previousIns = data.instructions[pos + modifier]
					local endOfFunctionDeclaration = false

					while (previousIns ~= nil) do
						if previousIns.OP_CODE == INST.TGETS then
							fName = data.consts[previousIns.C] .. "." .. fName
						elseif previousIns.OP_CODE == INST.GGET then
							fName = data.consts[previousIns.D] .. "." .. fName
							endOfFunctionDeclaration = true
							break
						else
							if DEBUG then
								print("Unexpected instruction : " .. OPNAMES[previousIns.OP_CODE])
							end
							fName = nil
							break
						end
						modifier = modifier - 1
						previousIns = data.instructions[pos + modifier]
					end
					if not endOfFunctionDeclaration then
						if DEBUG then
							print("Missing instruction GGET for getting global table")
						end
						fName = nil
					end
				else
					if DEBUG then
						print("WTF#1 ", nextIns.OP_ENGLISH, location._start, location._end)
					end
				end
			else
				if DEBUG then
					print("break")
				end
				break
			end
			-- local functions use FNEW but doesn't report any name
			if fName then
				location.name = fName
				table.insert(symbols, location)
				--symbols[fName] = location
			end
			if recursive then
				for _, subFunctionDeclaration in ipairs(get_function_declarations(data.consts[curIns.D], true)) do
					table.insert(symbols, subFunctionDeclaration)
				end

			end

		end
		pos = pos + 1
	end
	return symbols
end

function get_variables_declarations(fn, dumb_mode)
	local list = {}
	if dumb_mode then
		local n = -1
		local value = jit.util.funck(fn, n)

		while (value ~= nil) do
			if type(value) == "string" then
				table.insert(list, value)
			end
			n = n - 1
			value = jit.util.funck(fn, n)
		end
		return list
	else
		-- bruh
	end
end


local function fileGetSymbols(path, recursive)
	assert(path, "path expected")
	local file = assert(loadfile(path), "Could not open/compile file")
	local ret = get_function_declarations(file, recursive)
	return ret
end


local a = debug.getmetatable(disassemble_function) or {}
a.__index = a.__index or a -- assuming __index is not a function
local meta = a.__index -- when doing func.disassemble it's calling __index



debug.setmetatable(disassemble_function, a)
function meta.disassemble(...)
	return disassemble_function(...)
end

debug.setmetatable(hasJITInstruction, a)

function meta.isJITed(...)
	return hasJITInstruction(...)
end


debug.setmetatable(JITLevel, a)

function meta.getJITLevel(...)
	return JITLevel(...)
end


jit.getFileSymbols = fileGetSymbols
