--
--	HORN OF FROST
--		+5 damage when blue mana >= 20
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 3) then 
		if (GET_MANA_WATER(sourceIdx) >= 20) then
			damage = damage + 5;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	
	
	return damage;
end

--	
--		DECLARE TABLE	
--

IHOF = {
	OnGiveDamage = OnGiveDamage,
};



