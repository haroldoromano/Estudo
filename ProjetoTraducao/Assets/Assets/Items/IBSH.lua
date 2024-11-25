--
--	BROKEN SHIELD
--		Protects against 1 damage (10% chance)	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 10) then
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

IBSH = {
	OnReceiveDamage = OnReceiveDamage,
};





