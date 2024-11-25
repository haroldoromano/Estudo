--
--	PRIMITIVE TOWER
--		City Item (Posn #0 - Tower)
--		Adds +green/3 to damage	
--




------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + GET_MANA_EARTH(sourceIdx)/3;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end


--	
--		DECLARE TABLE	
--

ITWP = {
	OnGiveDamage = OnGiveDamage,
};














