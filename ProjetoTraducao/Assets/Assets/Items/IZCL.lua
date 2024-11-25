--
--	ZOMBIE CLAW
--		Adds +1 to all damage and Causes Disease (50%)	
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
	
	-- Add disease
	if (PERCENTILE_CHANCE_SYNC() <= 50) then
		ADD_STATUS_EFFECT(targetIdx,STATUS_EFFECT_DISEASE); 
		ADD_EFFECT_TO_CHARACTER(targetIdx,EFFECT_RED_SPARKLE);
	end

	return damage
end


--	
--		DECLARE TABLE	
--

IZCL = {
	OnGiveDamage = OnGiveDamage,
};





