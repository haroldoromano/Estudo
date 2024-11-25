--
--	ORKISH MANG
--		Each hit drains 1 Red Mana 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then
		SUBTRACT_MANA_FIRE(targetIdx,2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IORM = {
	OnGiveDamage = OnGiveDamage,
};



