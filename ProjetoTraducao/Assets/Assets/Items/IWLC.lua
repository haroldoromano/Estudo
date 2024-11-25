--
--	WOODLAND CLOAK
--		Every 3 points --> 1 Green mana 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	local extraMana = damage/3;
	if (extraMana > 0) then 
		ADD_MANA_EARTH(sourceIdx,extraMana);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IWLC = {
	OnGiveDamage = OnGiveDamage,
};


