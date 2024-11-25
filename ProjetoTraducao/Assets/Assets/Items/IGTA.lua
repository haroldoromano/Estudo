--
--	NEW ITEM
--		Protects against 2 damage (75% chance)	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 75) then
		if (damage > 4) then 
			damage = damage - 4;
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IGTA = {
	OnReceiveDamage = OnReceiveDamage,
};










