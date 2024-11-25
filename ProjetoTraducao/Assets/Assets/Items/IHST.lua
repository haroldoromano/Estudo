--
--	HUGE STINGER
--		Each hit adds +6 damage & has a 80% chance to poison 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 2) then
		damage = damage + 6;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	
	-- Add poison
	if (PERCENTILE_CHANCE_SYNC() <= 80) then
		ADD_STATUS_EFFECT(targetIdx,"EPOI"); 
		ADD_EFFECT_TO_CHARACTER(targetIdx,"GreenSparkle");
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

IHST = {
	OnGiveDamage = OnGiveDamage,
};


