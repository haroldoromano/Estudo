--
--	IRON SKIN
--		Protects against 1 damage & generates 1 Green Mana when struck
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage > 1) then 
		damage = damage - 1;
	end
	ADD_MANA_EARTH(targetIdx,1);
	NOTIFY_OF_ACTIVATED_ITEM();
	return damage;
end

--	
--		DECLARE TABLE	
--

IISK = {
	OnReceiveDamage = OnReceiveDamage,
};



