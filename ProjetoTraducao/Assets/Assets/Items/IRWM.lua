--
--	RING OF WARMTH
--		+8 Red Mana Resistance	
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

	if (manaIdx == MANA_RED) then
		value = value + 10;
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IRWM = {
	OnQueryResistance = OnQueryResistance,
};








