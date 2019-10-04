local tmp_documentation = {{op="ISLT",d="var",a="var",description="Jump if A < D",},{op="ISGE",d="var",a="var",description="Jump if A ≥ D",},{op="ISLE",d="var",a="var",description="Jump if A ≤ D",},{op="ISGT",d="var",a="var",description="Jump if A > D",},{op="ISEQV",d="var",a="var",description="Jump if A = D",},{op="ISNEV",d="var",a="var",description="Jump if A ≠ D",},{op="ISEQS",d="str",a="var",description="Jump if A = D",},{op="ISNES",d="str",a="var",description="Jump if A ≠ D",},{op="ISEQN",d="num",a="var",description="Jump if A = D",},{op="ISNEN",d="num",a="var",description="Jump if A ≠ D",},{op="ISEQP",d="pri",a="var",description="Jump if A = D",},{op="ISNEP",d="pri",a="var",description="Jump if A ≠ D",},{op="ISTC",d="var",a="dst",description="Copy D to A and jump",},{op="ISFC",d="var",a="dst",description="Copy D to A and jump",},{op="IST",d="var",a=" ",description="Jump if D is true",},{op="ISF",d="var",a=" ",description="Jump if D is false",},{op="MOV",d="var",a="dst",description="Copy D to A",},{op="NOT",d="var",a="dst",description="Set A to boolean not of D",},{op="UNM",d="var",a="dst",description="Set A to -D (unary minus)",},{op="LEN",d="var",a="dst",description="Set A to #D (object length)",},{op="ADDVN",a="dst",b="var",c="num",description="A = B + C",},{op="SUBVN",a="dst",b="var",c="num",description="A = B - C",},{op="MULVN",a="dst",b="var",c="num",description="A = B * C",},{op="DIVVN",a="dst",b="var",c="num",description="A = B / C",},{op="MODVN",a="dst",b="var",c="num",description="A = B % C",},{op="ADDNV",a="dst",b="var",c="num",description="A = C + B",},{op="SUBNV",a="dst",b="var",c="num",description="A = C - B",},{op="MULNV",a="dst",b="var",c="num",description="A = C * B",},{op="DIVNV",a="dst",b="var",c="num",description="A = C / B",},{op="MODNV",a="dst",b="var",c="num",description="A = C % B",},{op="ADDVV",a="dst",b="var",c="var",description="A = B + C",},{op="SUBVV",a="dst",b="var",c="var",description="A = B - C",},{op="MULVV",a="dst",b="var",c="var",description="A = B * C",},{op="DIVVV",a="dst",b="var",c="var",description="A = B / C",},{op="MODVV",a="dst",b="var",c="var",description="A = B % C",},{op="POW",a="dst",b="var",c="var",description="A = B ^ C",},{op="CAT",a="dst",b="rbase",c="rbase",description="A = B .. ~ .. C",},{op="KSTR",d="str",a="dst",description="Set A to string constant D",},{op="KCDATA",d="cdata",a="dst",description="Set A to cdata constant D",},{op="KSHORT",d="lits",a="dst",description="Set A to 16 bit signed integer D",},{op="KNUM",d="num",a="dst",description="Set A to number constant D",},{op="KPRI",d="pri",a="dst",description="Set A to primitive D",},{op="KNIL",d="base",a="base",description="Set slots A to D to nil",},{op="UGET",d="uv",a="dst",description="Set A to upvalue D",},{op="USETV",d="var",a="uv",description="Set upvalue A to D",},{op="USETS",d="str",a="uv",description="Set upvalue A to string constant D",},{op="USETN",d="num",a="uv",description="Set upvalue A to number constant D",},{op="USETP",d="pri",a="uv",description="Set upvalue A to primitive D",},{op="UCLO",d="jump",a="rbase",description="Close upvalues for slots ≥ rbase and jump to target D",},{op="FNEW",d="func",a="dst",description="Create new closure from prototype D and store it in A",},{op="TNEW",b="",["c/d"]="lit",a="dst",description="Set A to new table with size D (see below)",},{op="TDUP",b="",["c/d"]="tab",a="dst",description="Set A to duplicated template table D",},{op="GGET",b="",["c/d"]="str",a="dst",description="A = _G[D]",},{op="GSET",b="",["c/d"]="str",a="var",description="_G[D] = A",},{op="TGETV",b="var",["c/d"]="var",a="dst",description="A = B[C]",},{op="TGETS",b="var",["c/d"]="str",a="dst",description="A = B[C]",},{op="TGETB",b="var",["c/d"]="lit",a="dst",description="A = B[C]",},{op="TSETV",b="var",["c/d"]="var",a="var",description="B[C] = A",},{op="TSETS",b="var",["c/d"]="str",a="var",description="B[C] = A",},{op="TSETB",b="var",["c/d"]="lit",a="var",description="B[C] = A",},{op="TSETM",b="",["c/d"]="num*",a="base",description="(A-1)[D]",},{op="CALLM",b="lit",["c/d"]="lit",a="base",description="Call: A",},{op="CALL",b="lit",["c/d"]="lit",a="base",description="Call: A",},{op="CALLMT",b="",["c/d"]="lit",a="base",description="Tailcall: return A(A+1",},{op="CALLT",b="",["c/d"]="lit",a="base",description="Tailcall: return A(A+1",},{op="ITERC",b="lit",["c/d"]="lit",a="base",description="Call iterator: A",},{op="ITERN",b="lit",["c/d"]="lit",a="base",description="Specialized ITERC",},{op="VARG",b="lit",["c/d"]="lit",a="base",description="Vararg: A",},{op="ISNEXT",b="",["c/d"]="jump",a="base",description="Verify ITERN specialization and jump",},{op="RETM",d="lit",a="base",description="return A",},{op="RET",d="lit",a="rbase",description="return A",},{op="RET0",d="lit",a="rbase",description="return",},{op="RET1",d="lit",a="rbase",description="return A",},{op="FORI",d="jump",a="base",description="Numeric 'for' loop init",},{op="JFORI",d="jump",a="base",description="Numeric 'for' loop init",},{op="FORL",d="jump",a="base",description="Numeric 'for' loop",},{op="IFORL",d="jump",a="base",description="Numeric 'for' loop",},{op="JFORL",d="lit",a="base",description="Numeric 'for' loop",},{op="ITERL",d="jump",a="base",description="Iterator 'for' loop",},{op="IITERL",d="jump",a="base",description="Iterator 'for' loop",},{op="JITERL",d="lit",a="base",description="Iterator 'for' loop",},{op="LOOP",d="jump",a="rbase",description="Generic loop",},{op="ILOOP",d="jump",a="rbase",description="Generic loop",},{op="JLOOP",d="lit",a="rbase",description="Generic loop",},{op="JMP",d="jump",a="rbase",description="Jump",},{op="FUNCF",d="",a="rbase",description="Fixed-arg Lua function",},{op="IFUNCF",d="",a="rbase",description="Fixed-arg Lua function",},{op="JFUNCF",d="lit",a="rbase",description="Fixed-arg Lua function",},{op="FUNCV",d="",a="rbase",description="Vararg Lua function",},{op="IFUNCV",d="",a="rbase",description="Vararg Lua function",},{op="JFUNCV",d="lit",a="rbase",description="Vararg Lua function",},{op="FUNCC",d="",a="rbase",description="Pseudo-header for C functions",},{op="FUNCCW",d="",a="rbase",description="Pseudo-header for wrapped C functions",},{op="FUNC*",d="",a="rbase",description="Pseudo-header for fast functions",},}

local documentation = {}

for k, v in ipairs(tmp_documentation) do
	documentation[v.op] = v
end

local OPNAMES = {"ISLT", "ISGE", "ISLE", "ISGT", "ISEQV", "ISNEV", "ISEQS", "ISNES", "ISEQN", "ISNEN", "ISEQP", "ISNEP", "ISTC", "ISFC", "IST", "ISF", "MOV", "NOT", "UNM", "LEN", "ADDVN", "SUBVN", "MULVN", "DIVVN", "MODVN", "ADDNV", "SUBNV", "MULNV", "DIVNV", "MODNV", "ADDVV", "SUBVV", "MULVV", "DIVVV", "MODVV", "POW", "CAT", "KSTR", "KCDATA", "KSHORT", "KNUM", "KPRI", "KNIL", "UGET", "USETV", "USETS", "USETN", "USETP", "UCLO", "FNEW", "TNEW", "TDUP", "GGET", "GSET", "TGETV", "TGETS", "TGETB", "TSETV", "TSETS", "TSETB", "TSETM", "CALLM", "CALL", "CALLMT", "CALLT", "ITERC", "ITERN", "VARG", "ISNEXT", "RETM", "RET", "RET0", "RET1", "FORI", "JFORI", "FORL", "IFORL", "JFORL", "ITERL", "IITERL", "JITERL", "LOOP", "ILOOP", "JLOOP", "JMP", "FUNCF", "IFUNCF", "JFUNCF", "FUNCV", "IFUNCV", "JFUNCV", "FUNCC", "FUNCCW"}local INST = {}


local OPNAMES_C = {}
for k, v in ipairs(OPNAMES) do
	OPNAMES_C[k-1] = v
end

OPNAMES = OPNAMES_C

for k, v in ipairs(OPNAMES) do
	INST[v] = k
end


print(INST.FUNCC, "lol")

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
	--[INST.FUNC] = true
}


print(#OPNAMES)

local ref_table_set_vars = {
	GGET = function(instruction, consts, upvalues)
		instruction.A_value = consts[instruction.A]
	end,
	UGET = function(instruction, consts, upvalues)
		instruction.A_value = upvalues[instruction.A]
	end
}

local function getregisters(instruction, consts, upvalues)
	if ref_table_set_vars[instruction.OP_ENGLISH] then
		ref_table_set_vars[instruction.OP_ENGLISH](instruction, consts, upvalues)
	end
end

local function disassemble_function(fn)
	local upvalues = {}
	n = 0
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

	n = 1
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
		instruction.OP_ENGLISH = OPNAMES[instruction.OP_CODE]
		local documentation = documentation[instruction.OP_ENGLISH]
		instruction.OP_DESCRIPTION = documentation.description

		if (documentation.c and documentation.c:len() > 0) or (documentation["c/d"] and documentation["c/d"]:len() > 0) then
			instruction.C = bit.rshift(bit.band(ins, 0x00ff0000), 16)
		end

		if documentation.b and documentation.b:len() > 0 then
			instruction.B = bit.rshift(ins, 24)
		end

		if documentation.a and documentation.a:len() > 0 then
			instruction.A = bit.rshift(bit.band(ins, 0x0000ff00), 8)
		end

		if (documentation.d and documentation.d:len() > 0) or (documentation["c/d"] and documentation["c/d"]:len() > 0) then
			instruction.D = bit.rshift(ins, 16)
		end

		getregisters(instruction, consts, upvalues)
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

local a = debug.getmetatable(disassemble_function) or {}
a.__index = a.__index or a -- assuming __index is not a function
local meta = a.__index -- when doing func.disassemble it's calling __index
debug.setmetatable(disassemble_function, a)

function meta.disassemble(fn)
	return disassemble_function(fn)
end
