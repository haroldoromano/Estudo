--
--	HOLY LANCE
--		+Air/7 Damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + GET_MANA_AIR(sourceIdx)/7;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IHLA = {
	OnGiveDamage = OnGiveDamage,
};





