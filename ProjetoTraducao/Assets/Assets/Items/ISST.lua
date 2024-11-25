--
--	SHAMAN'S STAFF
--		+1 Damage (if damage >= 3), +1 Green Mana	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + 1;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

local function OnReceiveMana(value,characterIdx,manaType)
	if (manaType == MANA_GREEN) then
		value = value+1;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value;
end


--	
--		DECLARE TABLE	
--

ISST = {
	OnGiveDamage = OnGiveDamage,
	OnReceiveMana = OnReceiveMana,
};




