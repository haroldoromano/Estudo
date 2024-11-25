--
--	JOTUN'S BOOTS
--		+1 other mana when you receive 2+ Red Mana	
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

	if (manaType == MANA_RED and value >= 2) then
		ADD_MANA_AIR(characterIdx,1);
		ADD_MANA_EARTH(characterIdx,1);
		ADD_MANA_WATER(characterIdx,1);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IJOB = {
	OnReceiveMana = OnReceiveMana,
};



