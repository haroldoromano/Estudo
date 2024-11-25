--
--	ARKLICHE STAFF
--		-2 XP for each damage	

------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (sourceIdx ~= targetIdx) then
		SUBTRACT_XP(targetIdx,damage*2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end

--




--	
--		DECLARE TABLE	
--

IALS = {
	OnGiveDamage = OnGiveDamage,
};








