--
--	DRAGON SCALES
--		Nullify damage of 2 or lower	
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
	if (damage <= 2) then
		damage = 0;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IDSC = {
	OnReceiveDamage = OnReceiveDamage,
};



