--
--	GIANT MAUL
--		Adds +4 to all damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then
		damage = damage + 4;
	end
	NOTIFY_OF_ACTIVATED_ITEM();
	return damage;
end

--	
--		DECLARE TABLE	
--

IGIM = {
	OnGiveDamage = OnGiveDamage,
};


