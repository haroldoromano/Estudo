--
--	MOAT
--		City Item (Special, Pos #4)
--		Double Blue & +10 Fire Resistance	






------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)

	if (manaIdx == MANA_RED) then
		value = value + 10;
	end
	return value;
end

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
		value = value*2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end



--	
--		DECLARE TABLE	
--

IMOA = {
	OnReceiveMana = OnReceiveMana,
	OnQueryResistance = OnQueryResistance,
};








