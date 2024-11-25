--
--	IMPERIAL HELM
--		20% chance to reduce damage of 2+ to 1 pt	
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

	if (damage >= 2 and PERCENTILE_CHANCE_SYNC() < 20) then
		damage = 1;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end


--	
--		DECLARE TABLE	
--

IIMH = {
	OnReceiveDamage = OnReceiveDamage,
};




