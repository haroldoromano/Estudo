--
--	DUGOGS CLUB
--		20% chance of +12 damage	
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

	if (PERCENTILE_CHANCE_SYNC() <= 20) then
		if (damage > 1) then 
			damage = damage + 12;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IDCL = {
	OnGiveDamage = OnGiveDamage,
};







