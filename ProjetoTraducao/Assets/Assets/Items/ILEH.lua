--
--	LEATHER HELM
--		Protects against 1 damage (25% chance)	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (PERCENTILE_CHANCE_SYNC() <= 25) then
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

ILEH = {
	OnReceiveDamage = OnReceiveDamage,
};


