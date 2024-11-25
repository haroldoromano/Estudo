--
--	DRAGON CLAW
--		+3 damage and 2ach hit Leeches 2 Yellow Mana 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then
		damage = damage + 3;
		local amt = 2;
		SUBTRACT_MANA_AIR(targetIdx,amt);
		ADD_MANA_AIR(sourceIdx,amt);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IDCW = {
	OnGiveDamage = OnGiveDamage,
};



