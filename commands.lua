local EYEON, EyeOn = ...

EyeOn.commands = {}

-- Commands help

local function printHelp()
	print("/eyeon add <player> - Add character to the watch list by name. Can add multiple characters at once if SPACE seperated.")
	print("/eyeon remove <player> - Removes specific character. Can remove multiple characters at once if SPACE seperated.")
	print("/eyeon hidenames - Hide all character names.")
	print("/eyeon shownames - Shows all character names.")
	print("/eyeon reset - Removes all the players from watch list.")
	print("/eyeon bladd <player> - Adds player to black list and will be permanently removed from Eyeon.")
	print("/eyeon blremove <player> - Removes player from black list.")
	print("/eyeon blhide - Hides blacklist.")
	print("/eyeon blshow - Show blacklist.")
	print("/eyeon hide - Hide EyeOn window.")
	print("/eyeon show - Show Eyeon window.")
end

-- Command Table - Self explanetory --

local commandTable = {
	["show"] = function()
					print("Using first SHOW!")
					EyeOnFrame:Show()
				end,
	["hide"] = function()
					print("Using first HIDE!")
					EyeOnFrame:Hide()
				end,
	["add"] = function(text)
					addPlayer(text)
				end,
	["remove"] = function(text)
					removePlayer(text)
				end,
	["reset"] = function()
					resetTable()
				end,
	["blshow"] = function()
					blacklistFrameUpdate()
					blacklistFrame:Show()
				end,
	["blhide"] = function()
					blacklistFrame:Hide()
				end,
	["bladd"] = function(text)
					blacklistAdd(text)
				end,
	["blremove"] = function(text)
					blacklistRemove(text)
				end,				
	["blacklist"] = {
		["show"] = function()
						blacklistFrameUpdate()
						blacklistFrame:Show()
					end,
		["hide"] = function()
						blacklistFrame:Hide()
					end,
		["add"] = function(text)
						blacklistAdd(text)
					end,
		["remove"] = function(text)
						blacklistRemove(text)
					end
	},
	["bl"] = {
		["show"] = function()
						blacklistFrameUpdate()
						blacklistFrame:Show()
					end,
		["hide"] = function()
						blacklistFrame:Hide()
					end,
		["add"] = function(text)
						blacklistAdd(text)
					end,
		["remove"] = function(text)
						blacklistRemove(text)
					end
	},
	["hidenames"] = function()
					hideNames()
				end,
	["shownames"] = function()
					showNames()
				end,
	["help"] = function()
					printHelp()
				end,
	["removedtable"] = function()
					printRemove()
				end,
	["charactertable"] = function()
					printCharacter()
				end,
	[""] = function()
					printHelp()
				end
}

-- Executes the slash commands. --
-- Argument - Player entered text. --

local function commandExecute(text, tabel)
	local command, parameters = strsplit(" ", text, 2)
	local entry = tabel[command:lower()]
	local which = type(entry)
	if which == "function" then
		entry(parameters)
	elseif which == "table" then
		commandExecute(parameters, entry)
	end
end

EyeOn.commands.commandTable = commandTable
EyeOn.commands.commandExecute = commandExecute