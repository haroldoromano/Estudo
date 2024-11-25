--
--	RUNEKEEPER'S TOME
--		Doubles damage for each mana reserve that is full.	

------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (GET_MANA_AIR(sourceIdx) >= GET_MAX_MANA_AIR(sourceIdx)) then 
		damage = damage*1.5;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	if (GET_MANA_WATER(sourceIdx) >= GET_MAX_MANA_WATER(sourceIdx)) then 
		damage = damage*1.5;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	if (GET_MANA_EARTH(sourceIdx) >= GET_MAX_MANA_EARTH(sourceIdx)) then 
		damage = damage*1.5;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	if (GET_MANA_FIRE(sourceIdx) >= GET_MAX_MANA_FIRE(sourceIdx)) then 
		damage = damage*1.5;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IRKT = {
	OnGiveDamage = OnGiveDamage,
};





