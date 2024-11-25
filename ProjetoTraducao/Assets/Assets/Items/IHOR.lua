--
--	HEAVENLY ORB
--		Power Description	
--




------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)

	if (manaIdx == MANA_YELLOW) then
		value = value + GET_MANA_AIR(characterIdx)/2;
	end

	return value;
end


--	
--		DECLARE TABLE	
--

IHOR = {
	OnQueryResistance = OnQueryResistance,
};



