--
--	SMALL TOWER
--		City Item (Posn #0 - Tower)
--		Adds +2 to all damage of 2+	
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

	if (damage > 1) then
		damage = damage+2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

ITWS = {
	OnGiveDamage = OnGiveDamage,
};








