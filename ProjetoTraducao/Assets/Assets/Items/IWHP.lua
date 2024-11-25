--
--	WHIP
--		+1 damage when you get yellow mana	
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

	if (manaType == MANA_YELLOW) then
		Std_InflictDamage(1,characterIdx);
		NOTIFY_OF_ACTIVATED_ITEM();
	end

	return value
end


--	
--		DECLARE TABLE	
--

IWHP = {
	OnReceiveMana = OnReceiveMana,
};




