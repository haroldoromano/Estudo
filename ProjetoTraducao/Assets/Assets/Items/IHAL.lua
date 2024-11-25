--
--	HALBERD
--		+1 damage and destroys all red skulls	
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
	local maxLife = GET_MAX_LIFE(targetIdx);
	local currentLife = GET_LIFE(targetIdx);
	if (currentLife < maxLife/4) then
		damage = damage*2;
		NOTIFY_OF_ACTIVATED_ITEM()
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IHAL = {
	OnGiveDamage = OnGiveDamage,
};







