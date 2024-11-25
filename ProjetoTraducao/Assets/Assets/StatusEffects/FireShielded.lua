--
--	FIRE SHIELD
--		Subtract 1 from all damage of 2+
--

local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage > 1) then 
		damage = damage - 1;
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

FireShielded = {
	OnReceiveDamage = OnReceiveDamage,
};

