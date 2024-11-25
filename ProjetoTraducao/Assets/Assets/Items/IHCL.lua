--
--	HARPY CLAW
--		Each hit Leeches 1 Red & Yellow Mana 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then
		local amt = damage/3;
		SUBTRACT_MANA_FIRE(targetIdx,amt);
		SUBTRACT_MANA_AIR(targetIdx,amt);
		ADD_MANA_FIRE(sourceIdx,amt);
		ADD_MANA_AIR(sourceIdx,amt);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IHCL = {
	OnGiveDamage = OnGiveDamage,
};

