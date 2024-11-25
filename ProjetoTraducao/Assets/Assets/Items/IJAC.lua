--
--	JARL'S CLOAK
--		+2 All Blue Mana	
--




------------------------------------------------
--
-- OnReceiveMana
--
--    Called whenever a character receives mana
--    Must return the amount of mana received (value)
--     manaType is one of MANA_GREEN, MANA_RED, etc...
--
local function OnReceiveMana(value,characterIdx,manaType)
	
	if (manaType == MANA_BLUE) then
		value = value + 2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end


--	
--		DECLARE TABLE	
--

IJAC = {
	OnReceiveMana = OnReceiveMana,
};




