--
--	HARPYS CROWN
--		+1% Air Res on Damage 5+	
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

	if (damage >= 5) then
		ADD_TEMP_RESISTANCE(targetIdx, MANA_YELLOW, 1);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IHCR = {
	OnReceiveDamage = OnReceiveDamage,
};






