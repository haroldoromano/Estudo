--
--	PHOENIX SHIELD
--		Each 2 damage adds +1 Red & Green Mana	
--




------------------------------------------------
--
-- OnReceiveDamage
--
--    Called whenever a character takes damage
--    Must return the amount of damage taken
--     sourceIdx = attacker  targetIdx=me!
--
local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	
	local addMana = damage/2;
	if (addMana >= 1) then
		ADD_MANA_EARTH(targetIdx, addMana);
		ADD_MANA_FIRE(targetIdx, addMana);
	end

	return damage
end


--	
--		DECLARE TABLE	
--

IROS = {
	OnReceiveDamage = OnReceiveDamage,
};




