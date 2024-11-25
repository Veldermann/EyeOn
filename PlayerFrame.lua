
local EYEON, EyeOn = ...


local function createPlayerMenu(playerFrame)
	-- Player Menu
	playerFrame.playerMenu = CreateFrame("Frame", "playerMenu", playerFrame, BackdropTemplateMixin and "BackdropTemplate")
	playerFrame.playerMenu:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	playerFrame.playerMenu:SetBackdropColor(0,0,0,1)
	playerFrame.playerMenu:SetSize(125, 50)
	playerFrame.playerMenu:SetPoint("CENTER", playerFrame, "CENTER", 0, -20)
	playerFrame.playerMenu:EnableMouse(true)
	playerFrame.playerMenu:SetScript("OnLeave", function(self, event)
		local mouseFocusFrame = GetMouseFoci()[1]:GetParent()
		if mouseFocusFrame then
			if GetMouseFoci()[1]:GetParent() ~= self then
				playerFrame.playerMenu:Hide()
			end
		else
			playerFrame.playerMenu:Hide()
		end
	end)
	playerFrame.playerMenu:Hide()

	    -- Player Menu Options --

    -- Remove Player
	playerFrame.playerMenu.removePlayerOption = CreateFrame("Button", "RemovePlayerOption", playerFrame.playerMenu)
	playerFrame.playerMenu.removePlayerOption:SetNormalFontObject("GameFontNormalSmall")
	playerFrame.playerMenu.removePlayerOption:EnableMouse(true)
	playerFrame.playerMenu.removePlayerOption:SetText("Remove Player")
	playerFrame.playerMenu.removePlayerOption:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			removePlayerFrame(self:GetParent():GetParent())
		end
	end)
	playerFrame.playerMenu.removePlayerOption:SetSize(75, 20)
	playerFrame.playerMenu.removePlayerOption:RegisterForClicks("AnyUp")
	playerFrame.playerMenu.removePlayerOption:SetPoint("CENTER", playerFrame.playerMenu, "TOP", 0, -15)

    -- Blacklist Player
    playerFrame.playerMenu.blacklistPlayerOption = CreateFrame("Button", "BlacklistPlayerOption", playerFrame.playerMenu)
	playerFrame.playerMenu.blacklistPlayerOption:SetNormalFontObject("GameFontNormalSmall")
	playerFrame.playerMenu.blacklistPlayerOption:EnableMouse(true)
	playerFrame.playerMenu.blacklistPlayerOption:SetText("Blacklist Player")
	playerFrame.playerMenu.blacklistPlayerOption:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
            print("Missing blacklist function . . .")
			--removePlayerFrame(self:GetParent():GetParent())
		end
	end)
	playerFrame.playerMenu.blacklistPlayerOption:SetSize(75, 20)
	playerFrame.playerMenu.blacklistPlayerOption:RegisterForClicks("AnyUp")
	playerFrame.playerMenu.blacklistPlayerOption:SetPoint("CENTER", playerFrame.playerMenu, "TOP", 0, -35)
end

local function showCharacterOptions(playerFrame)
	playerFrame.playerMenu:Show()
	playerFrame.playerMenu:SetPoint("CENTER", playerFrame, "CENTER", 0, -20)
	playerFrame.playerMenu:SetFrameLevel(3)
end

local function createPlayerFrame(player)
	playerFrame = CreateFrame("Button", player, EyeOnFrame, "SecureUnitButtonTemplate")
	playerFrame:SetNormalFontObject("GameFontNormalSmall")
	playerFrame:SetScript("OnEnter", function (self, event)
		loadGameTooltipInfo(self)
	end)
    playerFrame:SetScript("OnLeave", function(self, event)
			GameTooltip:Hide()
		end)
    playerFrame:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" then
			showCharacterOptions(self)
		end
	end)
    playerFrame:SetSize(100, 25)
    playerFrame:RegisterForClicks("AnyUp")
	playerFrame:SetPoint("CENTER", EyeOnFrame, "TOP", 0, 0)
	playerFrame:SetAttribute("type", "target")
	playerFrame:SetAttribute("unit", player)
	playerFrame:SetFrameLevel(2)
	createPlayerMenu(playerFrame)

	table.insert(charactersTable, player)
end

EyeOn.PlayerFrame.createPlayerFrame = createPlayerFrame