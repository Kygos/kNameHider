kNameHider = LibStub("AceAddon-3.0"):NewAddon("kNameHider", "AceConsole-3.0")

local options = {
	name = "kNameHider",
	handler = "kNameHider",
	type = "group",
	args = {
		msg = {
			type = "toggle",
			name = "Show Text",
			desc = "Show text when it hides/shows",
			get = "", -- Empty for now.
			set = "", -- Empty for now.
		},
	},
}

local defaults = { 
	profile = {
		message = "Hiding!",
		on = true,
		off = false,
	},
}
function kNameHider:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("kNameHiderDB", defaults, true)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("kNameHider", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("kNameHider", "kNameHider")
	self:RegisterChatCommand("knh", "ChatCommand")
end

function kNameHider:OnEnable()
 
	local PieEater = function()
	  local name, type, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
		-- print(name.. " ".. type .." ".. difficulty)	
		if type == "raid" or type == "party" and GetNumGroupMembers() > 3 then
		SetCVar("UnitNameFriendlyPlayerName", 0)
		-- print("|cffff6060Hiding.")
		-- print(GetNumGroupMembers())	
		else
		SetCVar("UnitNameFriendlyPlayerName", 1)
		-- print("|cff00ccffShowing.")
		end
	end
end

local registerStuff = CreateFrame("Frame")
registerStuff:SetScript("OnEvent", PieEater)
registerStuff:RegisterEvent("PLAYER_ENTERING_WORLD")
registerStuff:RegisterEvent("RAID_ROSTER_UPDATE")
registerStuff:RegisterEvent("PARTY_MEMBERS_CHANGED")
