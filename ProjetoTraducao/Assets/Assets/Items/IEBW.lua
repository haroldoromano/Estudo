--
--	Erik's Bow
--		1+Level/5 damage	

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
		damage = damage + 1 + GET_LEVEL(sourceIdx)/8;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end

--




--	
--		DECLARE TABLE	
--

IEBW = {
	OnGiveDamage = OnGiveDamage,
};







