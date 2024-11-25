--
--	GNOLLKRYSS
--		+1 Life per 3 points done	
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

	if (damage >= 4) then
		local addLife = damage/4;
		ADD_MAX_LIFE(sourceIdx,addLife);
		ADD_LIFE(sourceIdx,addLife);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IGKR = {
	OnGiveDamage = OnGiveDamage,
};








