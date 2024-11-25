--
--	SPIKED CLUB
--		+2 Red Mana on 5 or more damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 5) then 
		ADD_MANA_FIRE(sourceIdx,2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

ISPC = {
	OnGiveDamage = OnGiveDamage,
};


