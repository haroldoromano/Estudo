--
--	ELEVEN HELM
--		+1% Earth resistance per Green over 5 	


------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)

	if (manaIdx == MANA_GREEN) then
		local mana = GET_MANA_EARTH(characterIdx);
		if (mana > 5) then
			value = value + mana - 5;
		end
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IELH = {
	OnQueryResistance = OnQueryResistance,
};









