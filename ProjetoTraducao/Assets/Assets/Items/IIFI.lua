--
--	IRON FISTS
--		Adds +2 to ALL damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	return damage + 2;
end

--	
--		DECLARE TABLE	
--

IIFI = {
	OnGiveDamage = OnGiveDamage,
};


