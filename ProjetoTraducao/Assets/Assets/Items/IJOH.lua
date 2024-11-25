--
--	JOTUN'S HELM
--		+1% Fire Resistance whenever you get 3+ Red Mana	
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

	if (manaType == MANA_RED and value >= 3) then
		ADD_TEMP_RESISTANCE(characterIdx, MANA_RED, 1);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end


--	
--		DECLARE TABLE	
--

IJOH= {
	OnReceiveMana = OnReceiveMana,
};



