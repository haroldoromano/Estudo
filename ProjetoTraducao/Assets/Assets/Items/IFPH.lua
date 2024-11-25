--
--	FULL PLATE HELM
--		Protects against 1 damage 	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage > 1) then 
		damage = damage - 1;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IFPH = {
	OnReceiveDamage = OnReceiveDamage,
};




