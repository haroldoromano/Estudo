--
--	WIGHTBLADE
--		Drains 5 Red Mana and adds it to my Blue Mana	
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
		local enemyRed = GET_MANA_FIRE(targetIdx);
		if (enemyRed > 0) then
			if (enemyRed > 5) then
				enemyRed = 5;
			end
			SUBTRACT_MANA_FIRE(targetIdx,enemyRed);
			ADD_MANA_WATER(sourceIdx,enemyRed);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IWBL = {
	OnGiveDamage = OnGiveDamage,
};









