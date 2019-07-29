AddCSLuaFile()



local json = [[ [{"op":"ISLT","a":"var","d":"var","description":"Jump if A < D"},{"op":"ISGE","a":"var","d":"var","description":"Jump if A ≥ D"},{"op":"ISLE","a":"var","d":"var","description":"Jump if A ≤ D"},{"op":"ISGT","a":"var","d":"var","description":"Jump if A > D"},{"op":"ISEQV","a":"var","d":"var","description":"Jump if A = D"},{"op":"ISNEV","a":"var","d":"var","description":"Jump if A ≠ D"},{"op":"ISEQS","a":"var","d":"str","description":"Jump if A = D"},{"op":"ISNES","a":"var","d":"str","description":"Jump if A ≠ D"},{"op":"ISEQN","a":"var","d":"num","description":"Jump if A = D"},{"op":"ISNEN","a":"var","d":"num","description":"Jump if A ≠ D"},{"op":"ISEQP","a":"var","d":"pri","description":"Jump if A = D"},{"op":"ISNEP","a":"var","d":"pri","description":"Jump if A ≠ D"},{"op":"ISTC","a":"dst","d":"var","description":"Copy D to A and jump"},{"op":"ISFC","a":"dst","d":"var","description":"Copy D to A and jump"},{"op":"IST","a":" ","d":"var","description":"Jump if D is true"},{"op":"ISF","a":" ","d":"var","description":"Jump if D is false"},{"op":"MOV","a":"dst","d":"var","description":"Copy D to A"},{"op":"NOT","a":"dst","d":"var","description":"Set A to boolean not of D"},{"op":"UNM","a":"dst","d":"var","description":"Set A to -D (unary minus)"},{"op":"LEN","a":"dst","d":"var","description":"Set A to #D (object length)"},{"op":"ADDVN","a":"dst","b":"var","c":"num","description":"A = B + C"},{"op":"SUBVN","a":"dst","b":"var","c":"num","description":"A = B - C"},{"op":"MULVN","a":"dst","b":"var","c":"num","description":"A = B * C"},{"op":"DIVVN","a":"dst","b":"var","c":"num","description":"A = B / C"},{"op":"MODVN","a":"dst","b":"var","c":"num","description":"A = B % C"},{"op":"ADDNV","a":"dst","b":"var","c":"num","description":"A = C + B"},{"op":"SUBNV","a":"dst","b":"var","c":"num","description":"A = C - B"},{"op":"MULNV","a":"dst","b":"var","c":"num","description":"A = C * B"},{"op":"DIVNV","a":"dst","b":"var","c":"num","description":"A = C / B"},{"op":"MODNV","a":"dst","b":"var","c":"num","description":"A = C % B"},{"op":"ADDVV","a":"dst","b":"var","c":"var","description":"A = B + C"},{"op":"SUBVV","a":"dst","b":"var","c":"var","description":"A = B - C"},{"op":"MULVV","a":"dst","b":"var","c":"var","description":"A = B * C"},{"op":"DIVVV","a":"dst","b":"var","c":"var","description":"A = B / C"},{"op":"MODVV","a":"dst","b":"var","c":"var","description":"A = B % C"},{"op":"POW","a":"dst","b":"var","c":"var","description":"A = B ^ C"},{"op":"CAT","a":"dst","b":"rbase","c":"rbase","description":"A = B .. ~ .. C"},{"op":"KSTR","a":"dst","d":"str","description":"Set A to string constant D"},{"op":"KCDATA","a":"dst","d":"cdata","description":"Set A to cdata constant D"},{"op":"KSHORT","a":"dst","d":"lits","description":"Set A to 16 bit signed integer D"},{"op":"KNUM","a":"dst","d":"num","description":"Set A to number constant D"},{"op":"KPRI","a":"dst","d":"pri","description":"Set A to primitive D"},{"op":"KNIL","a":"base","d":"base","description":"Set slots A to D to nil"},{"op":"UGET","a":"dst","d":"uv","description":"Set A to upvalue D"},{"op":"USETV","a":"uv","d":"var","description":"Set upvalue A to D"},{"op":"USETS","a":"uv","d":"str","description":"Set upvalue A to string constant D"},{"op":"USETN","a":"uv","d":"num","description":"Set upvalue A to number constant D"},{"op":"USETP","a":"uv","d":"pri","description":"Set upvalue A to primitive D"},{"op":"UCLO","a":"rbase","d":"jump","description":"Close upvalues for slots ≥ rbase and jump to target D"},{"op":"FNEW","a":"dst","d":"func","description":"Create new closure from prototype D and store it in A"},{"op":"TNEW","a":"dst","b":"","c/d":"lit","description":"Set A to new table with size D (see below)"},{"op":"TDUP","a":"dst","b":"","c/d":"tab","description":"Set A to duplicated template table D"},{"op":"GGET","a":"dst","b":"","c/d":"str","description":"A = _G[D]"},{"op":"GSET","a":"var","b":"","c/d":"str","description":"_G[D] = A"},{"op":"TGETV","a":"dst","b":"var","c/d":"var","description":"A = B[C]"},{"op":"TGETS","a":"dst","b":"var","c/d":"str","description":"A = B[C]"},{"op":"TGETB","a":"dst","b":"var","c/d":"lit","description":"A = B[C]"},{"op":"TSETV","a":"var","b":"var","c/d":"var","description":"B[C] = A"},{"op":"TSETS","a":"var","b":"var","c/d":"str","description":"B[C] = A"},{"op":"TSETB","a":"var","b":"var","c/d":"lit","description":"B[C] = A"},{"op":"TSETM","a":"base","b":"","c/d":"num*","description":"(A-1)[D]"},{"op":"CALLM","a":"base","b":"lit","c/d":"lit","description":"Call: A"},{"op":"CALL","a":"base","b":"lit","c/d":"lit","description":"Call: A"},{"op":"CALLMT","a":"base","b":"","c/d":"lit","description":"Tailcall: return A(A+1"},{"op":"CALLT","a":"base","b":"","c/d":"lit","description":"Tailcall: return A(A+1"},{"op":"ITERC","a":"base","b":"lit","c/d":"lit","description":"Call iterator: A"},{"op":"ITERN","a":"base","b":"lit","c/d":"lit","description":"Specialized ITERC"},{"op":"VARG","a":"base","b":"lit","c/d":"lit","description":"Vararg: A"},{"op":"ISNEXT","a":"base","b":"","c/d":"jump","description":"Verify ITERN specialization and jump"},{"op":"RETM","a":"base","d":"lit","description":"return A"},{"op":"RET","a":"rbase","d":"lit","description":"return A"},{"op":"RET0","a":"rbase","d":"lit","description":"return"},{"op":"RET1","a":"rbase","d":"lit","description":"return A"},{"op":"FORI","a":"base","d":"jump","description":"Numeric 'for' loop init"},{"op":"JFORI","a":"base","d":"jump","description":"Numeric 'for' loop init"},{"op":"FORL","a":"base","d":"jump","description":"Numeric 'for' loop"},{"op":"IFORL","a":"base","d":"jump","description":"Numeric 'for' loop"},{"op":"JFORL","a":"base","d":"lit","description":"Numeric 'for' loop"},{"op":"ITERL","a":"base","d":"jump","description":"Iterator 'for' loop"},{"op":"IITERL","a":"base","d":"jump","description":"Iterator 'for' loop"},{"op":"JITERL","a":"base","d":"lit","description":"Iterator 'for' loop"},{"op":"LOOP","a":"rbase","d":"jump","description":"Generic loop"},{"op":"ILOOP","a":"rbase","d":"jump","description":"Generic loop"},{"op":"JLOOP","a":"rbase","d":"lit","description":"Generic loop"},{"op":"JMP","a":"rbase","d":"jump","description":"Jump"},{"op":"FUNCF","a":"rbase","d":"","description":"Fixed-arg Lua function"},{"op":"IFUNCF","a":"rbase","d":"","description":"Fixed-arg Lua function"},{"op":"JFUNCF","a":"rbase","d":"lit","description":"Fixed-arg Lua function"},{"op":"FUNCV","a":"rbase","d":"","description":"Vararg Lua function"},{"op":"IFUNCV","a":"rbase","d":"","description":"Vararg Lua function"},{"op":"JFUNCV","a":"rbase","d":"lit","description":"Vararg Lua function"},{"op":"FUNCC","a":"rbase","d":"","description":"Pseudo-header for C functions"},{"op":"FUNCCW","a":"rbase","d":"","description":"Pseudo-header for wrapped C functions"},{"op":"FUNC*","a":"rbase","d":"","description":"Pseudo-header for fast functions"}] ]]
local tmp_documentation = util.JSONToTable(json)

local documentation = {}
for k, v in ipairs(tmp_documentation) do
	documentation[v.op] = v
end


-- https://gist.github.com/meepen/807dd81a572ffb0f28a8c44c04922fdd thx meepen my boi
local OPNAMES = {}
local bcnames = "ISLT  ISGE  ISLE  ISGT  ISEQV ISNEV ISEQS ISNES ISEQN ISNEN ISEQP ISNEP ISTC  ISFC  IST   ISF   MOV   NOT   UNM   LEN   ADDVN SUBVN MULVN DIVVN MODVN ADDNV SUBNV MULNV DIVNV MODNV ADDVV SUBVV MULVV DIVVV MODVV POW   CAT   KSTR  KCDATAKSHORTKNUM  KPRI  KNIL  UGET  USETV USETS USETN USETP UCLO  FNEW  TNEW  TDUP  GGET  GSET  TGETV TGETS TGETB TSETV TSETS TSETB TSETM CALLM CALL  CALLMTCALLT ITERC ITERN VARG  ISNEXTRETM  RET   RET0  RET1  FORI  JFORI FORL  IFORL JFORL ITERL IITERLJITERLLOOP  ILOOP JLOOP JMP   FUNCF IFUNCFJFUNCFFUNCV IFUNCVJFUNCVFUNCC FUNCCW"
-- ^^^^ took from luajit build
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

	if bit.band(select(1, jit.util.funcbc(fn, 0)), 0xFF) < INST.FUNCF then
		print("func decompiler : this should not happen")
	end


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
		if (documentation.c and documentation.c:len() > 0) or (documentation["c/d"] and  documentation["c/d"]:len() > 0)  then
			instruction.C = bit.rshift(bit.lshift(ins, 8), 24)
		end
		if documentation.b and documentation.b:len() > 0 then
			instruction.B = bit.rshift(ins, 24)
		end
		if documentation.a and documentation.a:len() > 0 then
			instruction.A = bit.rshift(bit.lshift(ins, 16), 24)
		end
		if (documentation.d and documentation.d:len() > 0) or (documentation["c/d"] and  documentation["c/d"]:len() > 0) then
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

local dummy = function() end
local a = debug.getmetatable(dummy) or {}
a.__index = a.__index or a -- assuming __index is not a function
local meta = a.__index
debug.setmetatable(dummy,a)

function meta.disassemble(fn)
	return disassemble_function(fn)
end
