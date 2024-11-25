--
--	BANES SHIELD
--		+1 all resistance per 3 points of EARTH
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

	value = value + GET_SKILL(characterIdx,SKILL_EARTH)/3;

	return value;
end



--	
--		DECLARE TABLE	
--

IBNX = {
	OnQueryResistance = OnQueryResistance,
};









