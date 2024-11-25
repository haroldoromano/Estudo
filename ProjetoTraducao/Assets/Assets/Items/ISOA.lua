--
--	SHIELD OF ALBION
--		+1% Air Resist when you get 3+ Yellow Mana	
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
	if (value >= 3 and manaType == MANA_YELLOW) then
		ADD_TEMP_RESISTANCE(characterIdx,MANA_YELLOW,1);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end


--	
--		DECLARE TABLE	
--

ISOA = {
	OnReceiveMana = OnReceiveMana,
};





