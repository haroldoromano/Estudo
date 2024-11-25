--
--	BLACK STAFF
--		+4 damage for each mana reserve that is full	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then
		if (GET_MANA_AIR(sourceIdx) >= GET_MAX_MANA_AIR(sourceIdx)) then 
			damage = damage + 4;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
		if (GET_MANA_WATER(sourceIdx) >= GET_MAX_MANA_WATER(sourceIdx)) then 
			damage = damage + 4;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
		if (GET_MANA_EARTH(sourceIdx) >= GET_MAX_MANA_EARTH(sourceIdx)) then 
			damage = damage + 4;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
		if (GET_MANA_FIRE(sourceIdx) >= GET_MAX_MANA_FIRE(sourceIdx)) then 
			damage = damage + 4;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IBST = {
	OnGiveDamage = OnGiveDamage,
};






