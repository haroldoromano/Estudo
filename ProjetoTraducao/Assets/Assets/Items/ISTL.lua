--
--	SARTEK'S TAIL
--		Does 1-10 damage whenever red gems are matched	

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
		local myDamage = GET_RANDOM_SYNC(1,10);
		Std_InflictDamage(myDamage, characterIdx);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end

--




--	
--		DECLARE TABLE	
--

ISTL = {
	OnReceiveMana = OnReceiveMana,
};




