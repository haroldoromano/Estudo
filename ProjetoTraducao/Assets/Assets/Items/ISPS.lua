--
--	SPIRIT STAFF
--		+1 All Mana on 3 or more damage 	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		ADD_MANA_FIRE(targetIdx,1);
		ADD_MANA_EARTH(targetIdx,1);
		ADD_MANA_AIR(targetIdx,1);
		ADD_MANA_WATER(targetIdx,1);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end


--	
--		DECLARE TABLE	
--

ISPS = {
	OnReceiveDamage = OnReceiveDamage,
};





