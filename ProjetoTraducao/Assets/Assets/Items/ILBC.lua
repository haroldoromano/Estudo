--
--	LICHEBANE CHARM
--		+6 to all damage vs Liches/Arkliches	
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

	if (damage >= 3) then
		local enemy = GET_CHARACTER_ID(targetIdx);
		if (enemy == "MLIC" or enemy == "MARK") then
			damage = damage + 6;
			NOTIFY_OF_ACTIVATED_ITEM();	
		end
	end
	return damage
end


--	
--		DECLARE TABLE	
--

ILBC = {
	OnGiveDamage = OnGiveDamage,
};











