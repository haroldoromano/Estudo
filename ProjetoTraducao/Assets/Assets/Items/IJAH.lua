--
--	JARL'S HAMMER
--		Does +2 Damage when you receive 2+ Blue Mana	
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

	if (manaType == MANA_BLUE and value >= 2) then
		Std_InflictDamage(2,characterIdx);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end


--	
--		DECLARE TABLE	
--

IJAH = {
	OnReceiveMana = OnReceiveMana,
};





