--
--	SCALE ARMOR
--		Protects against 1 damage (75% chance)	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 75) then
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

ISCH = {
	OnReceiveDamage = OnReceiveDamage,
};



