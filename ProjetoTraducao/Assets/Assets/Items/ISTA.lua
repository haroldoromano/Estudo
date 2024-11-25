--
--	SOULTREE AXE
--		Adds +2 Life on any hit of 4 or more
--




------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 4) then
		Std_Healing(2,sourceIdx); 
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

ISTA = {
	OnGiveDamage = OnGiveDamage,
};






