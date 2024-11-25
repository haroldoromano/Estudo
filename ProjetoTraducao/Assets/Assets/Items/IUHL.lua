--
--	UNHOLY LANCE
--		+Earth/7 Damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + GET_MANA_EARTH(sourceIdx)/7;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IUHL = {
	OnGiveDamage = OnGiveDamage,
};





