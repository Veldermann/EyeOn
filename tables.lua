local EYEON, EyeOn = ...

EyeOn.tables = {}


-- Class Color Table --

local classColorTable = {
	["DEATH KNIGHT"] = "|cFFC41F3B",
	["DENON HUNTER"] = "|cFFA330C9",
	["DRUID"] = "|cFFFF7D0A",
	["HUNTER"] = "|cFFABD473",
	["MAGE"] = "|cFF69CCF0",
	["MONK"] = "|cFF00FF96",
	["PALADIN"] = "|cFFF58CBA",
	["PRIEST"] = "|cFFFFFFFF",
	["ROGUE"] = "|cFFFFF569",
	["SHAMAN"] = "|cFF0070DE",
	["WARLOCK"] = "|cFF9482C9",
	["WARRIOR"] = "|cFFC79C6E"
}

-- EventTables --

local EyeOnEvents = {
	["UNIT_POWER_UPDATE"] = function()
								updateResource()
							end,
	["GROUP_ROSTER_UPDATE"] = function()
								autoAddCharacters()
							end,
	["RAID_ROSTER_UPDATE"] = function()
								autoAddCharacters()
							end,
	["PLAYER_LOGIN"] = function()
						autoAddCharacters()
					end
}

EyeOn.tables.classColorTable = classColorTable
EyeOn.tables.EyeOnEvents = EyeOnEvents