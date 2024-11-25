--
--	CHAIN LEGGINGS
--		Protects against 1 damage (50% chance)	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 50) then
		if (damage > 1) then 
			damage = damage - 1;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

ICMB = {
	OnReceiveDamage = OnReceiveDamage,
};



