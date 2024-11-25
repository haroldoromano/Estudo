--
--	IMPERIAL ARMOR
--		Power Description	
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
	if (damage >= 2) then
		ADD_XP(targetIdx, 2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IIAM = {
	OnReceiveDamage = OnReceiveDamage,
};




