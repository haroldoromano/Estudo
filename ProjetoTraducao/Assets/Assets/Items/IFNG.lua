--
--	HUGE FANGS
--		25% chance of poison 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 6) then
		damage = damage + 4;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	
	-- Add poison
	if (PERCENTILE_CHANCE_SYNC() <= 25) then
		ADD_STATUS_EFFECT(targetIdx,"EPOI"); 
		ADD_EFFECT_TO_CHARACTER(targetIdx,"GreenSparkle");
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

IFNG = {
	OnGiveDamage = OnGiveDamage,
};


