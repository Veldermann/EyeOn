
	-- INITIAL VARIABLES --

-- Lets add all the watched players in this table --

classTable = {"PRIEST", "SHAMAN", "DRUID", "PALADIN"}
charactersTable = {}
removedTable = {}
unusedFrames = {}

-- Create initial frame that retrieves Savedvariables and Creates the main addon frame --

init_frame = CreateFrame("Frame", "Initial_Frame", UIParent)
init_frame:RegisterEvent("ADDON_LOADED")
init_frame:SetScript("OnEvent", function()
									createAndLoad() 
								end)

-- Creates main frame, positions and add events --

function createAndLoad()

	init_frame:UnregisterEvent("ADDON_LOADED")
	
	if blacklistTable == nil then
		blacklistTable = {}
	end
	
	if positionXaxis == nil and positionYaxis == nil then
		positionXaxis = 0
		positionYaxis = 0
	end
	
	if sizeXaxis == nil and sizeYaxis == nil then
		sizeXaxis = 200
		sizeYaxis = 200
	end
	
	EyeOn = CreateFrame("Frame", "EyeOn", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	EyeOn:SetBackdrop({bgFile = [[Interface/Tooltips/UI-Tooltip-Background]], edgeFile = [[Interface/Tooltips/UI-Tooltip-Border]], tile = false, tileSize = 1, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	EyeOn:SetBackdropColor(0,0,0,0.6)
	EyeOn:SetSize(sizeXaxis, sizeYaxis)
	EyeOn:SetPoint("CENTER", UIParent, "CENTER", positionXaxis, positionYaxis)
	EyeOn:SetMovable(true)
	EyeOn:EnableMouse(true)
	EyeOn:SetResizable(true)
	EyeOn:RegisterForDrag("LeftButton")
	EyeOn:SetScript("OnDragStart", EyeOn.StartMoving)
	EyeOn:SetScript("OnDragStop", EyeOn.StopMovingOrSizing)
	EyeOn:SetResizeBounds(200, 200)
	for event, value in pairs(EyeOnEvents) do
		EyeOn:RegisterEvent(event)
	end
	EyeOn:SetScript("OnEvent", function(self, event, ...)
									EyeOnEvents[event]()
								end)
	print("Almost there")
	EyeOn.title = EyeOn:CreateFontString(nil, "OVERLAY")
	EyeOn.title:SetFontObject("GameFontNormalSmall")
	EyeOn.title:SetPoint("CENTER", EyeOn, "TOP", 0, -10)
	EyeOn.title:SetText("EyeOn")
	
	blacklistFrame = CreateFrame("Frame", "BlackListFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	blacklistFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	blacklistFrame:SetBackdropColor(0,0,0,0.6)
	blacklistFrame:SetSize(150, 150)
	blacklistFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	blacklistFrame:SetMovable(true)
	blacklistFrame:EnableMouse(true)
	blacklistFrame:RegisterForDrag("LeftButton")
	blacklistFrame:SetScript("OnDragStart", EyeOn.StartMoving)
	blacklistFrame:SetScript("OnDragStop", EyeOn.StopMovingOrSizing)
	blacklistFrame:Hide()
	
	blacklistFrame.title = blacklistFrame:CreateFontString(nil, "OVERLAY")
	blacklistFrame.title:SetFontObject("GameFontNormalSmall")
	blacklistFrame.title:SetPoint("CENTER", blacklistFrame, "TOP", 0, -10)
	blacklistFrame.title:SetText("EyeOn BlackList")

	blacklistFrame.text = blacklistFrame:CreateFontString(nil, "OVERLAY")
	blacklistFrame.text:SetFontObject("GameFontNormalSmall")
	blacklistFrame.text:SetPoint("CENTER", blacklistFrame.title, "BOTTOM", 0, -20)
	blacklistFrame.text:SetText("List of black listed players.")
	
	EyeOn.averageMana = EyeOn:CreateFontString(nil, "OVERLAY")
	EyeOn.averageMana:SetFontObject("GameFontNormalLarge")
	EyeOn.averageMana:SetPoint("CENTER", EyeOn.title, "BOTTOM", 0, -20)
	EyeOn.averageMana:SetText("Average : 0 %")
	
	druidAverage = CreateFrame("Button", "druidAverage", EyeOn)
	druidAverage:SetSize(25, 25)
	druidAverage:SetNormalFontObject("GameFontNormalLarge")
	druidAverage:SetPoint("CENTER", EyeOn.averageMana, "BOTTOM", 0, -15)
	
	priestAverage = CreateFrame("Button", "priestAverage", EyeOn)
	priestAverage:SetSize(25, 25)
	priestAverage:SetNormalFontObject("GameFontNormalLarge")
	priestAverage:SetPoint("CENTER", EyeOn.averageMana, "BOTTOM", 0, -30)

	shamanAverage = CreateFrame("Button", "shamanAverage", EyeOn)
	shamanAverage:SetSize(25, 25)
	shamanAverage:SetNormalFontObject("GameFontNormalLarge")
	shamanAverage:SetPoint("CENTER", EyeOn.averageMana, "BOTTOM", 0, -45)
	
	paladinAverage = CreateFrame("Button", "paladinAverage", EyeOn)
	paladinAverage:SetSize(25, 25)
	paladinAverage:SetNormalFontObject("GameFontNormalLarge")
	paladinAverage:SetPoint("CENTER", EyeOn.averageMana, "BOTTOM", 0, -60)
	
	print("EyeOn LOADED!")
end


-- Command Table - Self explanetory --

commandTable = {["show"] = function()
					print("Using first SHOW!")
					EyeOn:Show()
				end,
				["hide"] = function()
					print("Using first HIDE!")
					EyeOn:Hide()
				end,
				["add"] = function(text)
					addPlayer(text)
				end,
				["remove"] = function(text)
					removePlayer(text)
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
				["position"] = function(text)
					changePosition(text)
				end,
				["size"] = function(text)
					changeSize(text)
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

-- Class Color Table --

classColorTable = {
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

EyeOnEvents = {
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
				
-- Slash command --

SLASH_EyeOn1 = "/eyeon"
SLASH_EyeOn2 = "/eon"
SlashCmdList["EyeOn"] = function(text)
	commandExecute(text, commandTable)
end

-- Executes the slash commands. --
-- Argument - Player entered text. --

function commandExecute(text, tabel)
	local command, parameters = strsplit(" ", text, 2)
	local entry = tabel[command:lower()]
	local which = type(entry)
	if which == "function" then
		entry(parameters)
	elseif which == "table" then
		commandExecute(parameters, entry)
	end
end

function blacklistFrameUpdate()
	textToSet = ""
	for i=1, #blacklistTable do
		textToSet = textToSet .. blacklistTable[i] .. string.char(13)
	end
	blacklistFrame.text:SetText(textToSet)
end

function blacklistAdd(text)
	local characterToAdd = text:gsub("^%l", string.upper)
	for i=1, #charactersTable do
		if characterToAdd == charactersTable[i] then
			characterToBlacklist = _G[charactersTable[i]]
			characterToBlacklist:Hide()
			table.insert(unusedFrames, charactersTable[i])
			table.remove(charactersTable, i)
		end
	end

	for i=1, #blacklistTable do
		if characterToAdd == blacklistTable[i] then
			return
		end
	end

	table.insert(blacklistTable, characterToAdd)
	
	blacklistFrameUpdate()
	autoAddCharacters()
end

function blacklistRemove(text)
	local characterToRemove = text:gsub("^%l", string.upper)
	for i=1, #blacklistTable do
		if characterToRemove == blacklistTable[i] then
			table.remove(blacklistTable, i)
		end
	end
	blacklistFrameUpdate()
	autoAddCharacters()
end

function autoAddCharacters()

	for i=1, #charactersTable do
		inRaid = UnitInRaid(charactersTable[i])
		if not inRaid then
			inGroup = UnitInParty(charactersTable[i])
			if not inGroup then
				characterFrameToRemove = _G[charactersTable[i]]
				characterFrameToRemove:Hide()
				table.insert(unusedFrames, charactersTable[i])
				table.remove(charactersTable, i)
			end
		end
	end
	
	for i=1, GetNumGroupMembers() do

		name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)			
		
		if name then
		
			isInBlacklistTable = 0
			for i=1, #blacklistTable do
				if name == blacklistTable[i] then
					isInBlacklistTable = 1
				end
			end
			
			isInRemovedTable = 0
			for i=1, #removedTable do
				if name == removedTable[i] then
					isInRemovedTable = 1
				end
			end
			
			isInUnusedTable = 0
			for i=1, #unusedFrames do
				if name == unusedFrames[i] then
					isInUnusedTable = 1
				end
			end
			
			isInTableAlready = 0
			for i=1, #charactersTable do
				if name == charactersTable[i] then
					isInTableAlready = 1
				end
			end
			
			if isInBlacklistTable == 0 then
				if isInTableAlready == 0 then
					if isInRemovedTable == 0 then
						if isInUnusedTable == 1 then
							characterToAddFrame = _G[name]
							for i=1, #unusedFrames do
								if name == unusedFrames[i] then
									table.remove(unusedFrames, i)
									table.insert(charactersTable, name)
									characterToAddFrame:Show()
								end
							end
						else
							if fileName == "DRUID" or fileName == "PRIEST" or fileName == "SHAMAN" or fileName == "PALADIN" then
								playerButton = CreateFrame("Button", name, EyeOn, "SecureUnitButtonTemplate")
								playerButton:SetNormalFontObject("GameFontNormalSmall")
								playerButton:SetScript("OnEnter", function (self, event)
																	loadGameTooltipInfo(self)
																end)
								playerButton:SetScript("OnLeave", function(self, event)
																	GameTooltip:Hide()
																end)
								playerButton:SetSize(100, 25)
								playerButton:RegisterForClicks("AnyUp")
								playerButton:SetPoint("CENTER", EyeOn, "TOP", 0, 0)
								playerButton:SetAttribute("type", "target")
								playerButton:SetAttribute("unit", name)
								table.insert(charactersTable, name)
							end
						end
					end
				end
			end
		end
		updateResource()
	end
	updateResource()
end

function loadGameTooltipInfo(self)
	local frameName = self:GetName()
	GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT", -310, 190)
	GameTooltip:SetUnit(frameName)
	GameTooltip:Show()
end

function addPlayer(text)
			
	local players = {strsplit(" ", text)}
	
	for key, newCharacter in pairs(players) do
	
		isInUnusedTable = 0
	
		playerToAdd = newCharacter:gsub("^%l", string.upper)
		
		for characterKey, oldCharacter in pairs(unusedFrames) do
			if playerToAdd == oldCharacter then
				isInUnusedTable = 1
			end
		end
		
		isInRemovedTable = 0
		
		for characterKey, oldCharacter in pairs(removedTable) do
			if playerToAdd == oldCharacter then
				isInRemovedTable = 1
			end
		end
		
		isInCurrentTable = 0
		
		for key, currentCharacter in pairs(charactersTable) do
			if playerToAdd == currentCharacter then
				isInCurrentTable = 1
			end
		end
		
		if isInRemovedTable == 0 then
			if isInCurrentTable == 0 then
				if isInUnusedTable == 1 then
					characterToAddFrame = _G[playerToAdd]
					table.remove(unusedFrames, key)
					table.insert(charactersTable, playerToAdd)
					characterToAddFrame:Show()
					print(playerToAdd ..  " added to the Watch List")	
				else
					playerButton = CreateFrame("Button", playerToAdd, EyeOn, "SecureUnitButtonTemplate")
					playerButton:SetNormalFontObject("GameFontNormalSmall")
					playerButton:SetScript("OnEnter", function (self, event)
														loadGameTooltipInfo(self)
													end)
					playerButton:SetScript("OnLeave", function(self, event)
														GameTooltip:Hide()
													end)
					playerButton:SetSize(100, 25)
					playerButton:RegisterForClicks("AnyUp")
					playerButton:SetPoint("CENTER", EyeOn, "TOP", 0, 0)
					playerButton:SetAttribute("type", "target")
					playerButton:SetAttribute("unit", name)
					table.insert(charactersTable, playerToAdd)
					print(playerToAdd ..  " added to the Watch List")
				end
			else
				print("Character already in EyeOn watch list.")
			end
		else
			print("Character is removed till relog or /reload")		
		end
	end
	updateResource()
end

function removePlayer(text)
	local players = {strsplit(" ", text)}
	for key, value in pairs(players) do
		playerToRemove = value:gsub("^%l", string.upper)
		for characterKey, character in pairs(charactersTable) do
			if character == playerToRemove then
				table.insert(removedTable, character)
				characterToRemoveFrame = _G[character]
				characterToRemoveFrame:Hide()
				table.remove(charactersTable, characterKey)
				updateResource()
			end
		end
	end
end

function resetTable()
	for i=1, #charactersTable do
		playerToRemove = _G[charactersTable[1]]
		playerToRemove:Hide()
		table.insert(removedTable, charactersTable[1])
		table.remove(charactersTable, 1)
	end
	updateResource()
end


function changePosition(position)
	local positionx, positiony = strsplit(" ", position, 2)
	EyeOn:SetPoint("CENTER", UIParent, "CENTER", positionx, positiony)
	positionXaxis = positionx
	positionYaxis = positiony
end

function changeSize(size)
	local x, y = strsplit(" ", size, 2)
	EyeOn:SetSize(x, y)
	sizeXaxis = x
	sizeYaxis = y
end

function printHelp()
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

function showNames()
	for key, character in pairs(charactersTable) do
		nameToShow = _G[character]
		nameToShow:Show()
	end
	updateResource()
end

function hideNames()
	for key, character in pairs(charactersTable) do
		nameToHide = _G[character]
		nameToHide:Hide()
	end
	updateResource()
end

function classColor(key)
	localizedClass, englishClass = UnitClass(charactersTable[key])
	for class, color in pairs(classColorTable) do
		if class == englishClass then
			return color
		end
	end
end
	
function average(currentMana, maxMana)
	if maxMana == 0 then
		return 100
	end
	return math.floor(currentMana * 100 / maxMana)
end

function updateClassAverage(frame, class, classAverage)
	frame:Show()
	if classAverage >= 75 then
		frame:SetText("|cFF00FF00" .. class .. " : " .. classAverage .. " %")
	elseif classAverage >= 20 then
		frame:SetText("|cFFFFFF00" .. class .. " : " .. classAverage .. " %")
	else
		frame:SetText("|cFFFF0000" .. class .. " : " .. classAverage .. " %")
	end
end

function updateResource()
	characterTextOffset = -120
	eyeonSizeY = 120

	local maxMana = 0
	local currentMana = 0
	
	druidCurrentMana = 0
	druidMaxMana = 0
	druidCount = 0
	
	priestCurrentMana = 0
	priestMaxMana = 0
	priestCount = 0
	
	shamanCurrentMana = 0
	shamanMaxMana = 0
	shamanCount = 0
	
	paladinCurrentMana = 0
	paladinMaxMana = 0
	paladinCount = 0
	
	for class=1, #classTable do
		for key, character in pairs(charactersTable) do
			localizedClass, englishClass = UnitClass(charactersTable[key])
			if englishClass == classTable[class] then
				playerButton = _G[character]
				playerButton:SetPoint("CENTER", EyeOn, "TOP", 0, characterTextOffset)
				isPlayerFrameVisible = playerButton:IsShown()
				if isPlayerFrameVisible then
					characterTextOffset = characterTextOffset - 15
					eyeonSizeY = eyeonSizeY + 15
				end
				
				maxPower = UnitPowerMax(character, Mana, false)
				currentPower = UnitPower(character, Mana, false)
				manaPercent = math.floor(currentPower * 100 / maxPower)
				maxMana = maxMana + maxPower
				currentMana = currentMana + currentPower
				if englishClass == "DRUID" then
					druidCurrentMana = druidCurrentMana + currentPower
					druidMaxMana = druidMaxMana + maxPower
					druidCount = druidCount + 1
				elseif englishClass == "PRIEST" then
					priestCurrentMana = priestCurrentMana + currentPower
					priestMaxMana = priestMaxMana + maxPower
					priestCount = priestCount + 1
				elseif englishClass == "SHAMAN" then
					shamanCurrentMana = shamanCurrentMana + currentPower
					shamanMaxMana = shamanMaxMana + maxPower
					shamanCount = shamanCount + 1
				elseif englishClass == "PALADIN" then
					paladinCurrentMana = paladinCurrentMana + currentPower
					paladinMaxMana = paladinMaxMana + maxPower
					paladinCount = paladinCount + 1
				end
				
				if manaPercent > 74 then
					playerButton:SetText(classColor(key) .. character .. " - |cFF00FF00" .. manaPercent .. " %")
				elseif manaPercent > 25 then
					playerButton:SetText(classColor(key) .. character .. " - |cFFFFFF00" .. manaPercent .. " %")
				elseif manaPercent > 10 then
					playerButton:SetText(classColor(key) .. character .. " - |cFFFF0000" .. manaPercent .. " %")
				elseif UnitIsDeadOrGhost(character) then
					playerButton:SetText("|cFF808080" .. character .. " - DEAD")
				else
					playerButton:SetText("|cFFFF0000" .. character .. " - " .. manaPercent .. " %")
				end
			end
		end
	end
	
	EyeOn:SetSize(150, eyeonSizeY)
	EyeOn:SetResizeBounds(150, eyeonSizeY)
	
	local druidManaAverage = math.floor(druidCurrentMana * 100 / druidMaxMana)
	local priestManaAverage = math.floor(priestCurrentMana * 100 / priestMaxMana)
	local shamanManaAverage = math.floor(shamanCurrentMana * 100 / shamanMaxMana)
	local paladinManaAverage = math.floor(paladinCurrentMana * 100 / paladinMaxMana)
	
	if druidCount == 0 then
		druidAverage:Hide()
	else
		updateClassAverage(druidAverage, "Druid", druidManaAverage)
	end
	
	if priestCount == 0 then
		priestAverage:Hide()
	else
		updateClassAverage(priestAverage, "Priest", priestManaAverage)
	end
	
	if shamanCount == 0 then
		shamanAverage:Hide()
	else
		updateClassAverage(shamanAverage, "Shaman", shamanManaAverage)
	end
	
	if paladinCount == 0 then
		paladinAverage:Hide()
	else
		updateClassAverage(paladinAverage, "Paladin", paladinManaAverage)
	end
	
	averageManaPercent = math.floor(currentMana * 100 / maxMana)
	averageManaText = "Average : 0 %"
	
	if table.getn(charactersTable) <= 0 then
		EyeOn.averageMana:SetText("|cFF00FF00Average : " .. " %")
	elseif averageManaPercent >= 75 then
		EyeOn.averageMana:SetText("|cFF00FF00Average : " .. averageManaPercent .. " %")
	elseif averageManaPercent >= 20 then
		EyeOn.averageMana:SetText("|cFFFFFF00Average : " .. averageManaPercent .. " %")
	else
		EyeOn.averageMana:SetText("|cFFFF0000Average : " .. averageManaPercent .. " %")
	end	
end
