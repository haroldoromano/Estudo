--
--	SHIELD OF SACRIFICE
--		For each full 4 damage, this gives 1 of each mana 	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 4) then 
		local myMana = damage/4;
		ADD_MANA_EARTH(targetIdx,myMana);
		ADD_MANA_FIRE(targetIdx,myMana);
		ADD_MANA_AIR(targetIdx,myMana);
		ADD_MANA_WATER(targetIdx,myMana);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

ISSA = {
	OnReceiveDamage = OnReceiveDamage,
};


