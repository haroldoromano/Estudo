--
--	ELVEN PLATE
--		80% chance protection... +2 Green Mana	
--




------------------------------------------------
--
-- OnReceiveDamage
--
--    Called whenever a character takes damage
--    Must return the amount of damage taken
--     sourceIdx = attacker  targetIdx=me!
--
local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 80) then
		if (damage > 1) then 
			damage = damage - 1;
			ADD_MANA_EARTH(targetIdx,2);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IELP = {
	OnReceiveDamage = OnReceiveDamage,
};







