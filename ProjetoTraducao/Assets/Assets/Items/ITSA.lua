--
--	NEW ITEM
--		Power Description	
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
	damage = damage + 1;
	NOTIFY_OF_ACTIVATED_ITEM();
	return damage
end


--	
--		DECLARE TABLE	
--

ITSA = {
	OnGiveDamage = OnGiveDamage,
};




