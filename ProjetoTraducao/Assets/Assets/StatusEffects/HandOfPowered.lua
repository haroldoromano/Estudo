--
--	HAND OF POWER
--		+2 to damage each turn
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	return damage + 2;
end

--	
--		DECLARE TABLE	
--

HandOfPowered = {
	OnGiveDamage = OnGiveDamage,
};

