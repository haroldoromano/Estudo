--
--	NEW ITEM
--		Power Description	
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
	if (manaType == MANA_RED) then
		local extraMana = value/2;
		if (extraMana > 0) then
			ADD_MANA_EARTH(characterIdx, extraMana);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IBFH = {
	OnReceiveMana = OnReceiveMana,
};






