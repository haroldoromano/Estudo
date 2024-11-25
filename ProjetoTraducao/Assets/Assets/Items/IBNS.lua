--
--	BANES SWORD
--		+1 Damage per 3 pts of FIRE	
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
		damage = damage + GET_SKILL(sourceIdx,SKILL_FIRE)/3;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IBNS = {
	OnGiveDamage = OnGiveDamage,
};








