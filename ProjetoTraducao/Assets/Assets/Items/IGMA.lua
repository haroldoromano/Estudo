--
--	Great Mang
--		Has a 25% chance to drain the opponents 
--		Red Mana when it hits for 3 or more damage.	
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
		if (PERCENTILE_CHANCE_SYNC() <= 25) then
			SUBTRACT_MANA_FIRE(targetIdx,GET_MANA_FIRE(targetIdx));
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end

	return damage
end


--	
--		DECLARE TABLE	
--

IGMA = {
	OnGiveDamage = OnGiveDamage,
};






