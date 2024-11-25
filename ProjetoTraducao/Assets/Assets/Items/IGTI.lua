--
--	NEW ITEM
--		Protects against 2 damage (75% chance)	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 75) then
		if (damage > 3) then 
			damage = damage - 3;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IGTI = {
	OnReceiveDamage = OnReceiveDamage,
};









