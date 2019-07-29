AddCSLuaFile()

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
		instruction.C = bit.rshift(bit.lshift(ins, 8), 24)
		instruction.B = bit.rshift(ins, 24)
		instruction.A = bit.rshift(bit.lshift(ins, 16), 24)
		instruction.D = bit.rshift(ins, 16)
		instruction.OP_CODE = bit.band(ins, 0xFF)
		instruction.OP_ENGLISH = OPNAMES[instruction.OP_CODE]
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

